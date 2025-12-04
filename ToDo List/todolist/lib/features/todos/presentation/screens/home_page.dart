import 'package:flutter/material.dart';

import '../../../todos/domain/todo_entry.dart';
import '../widgets/animated_backdrop.dart';
import '../widgets/composer.dart';
import '../widgets/empty_state.dart';
import '../widgets/header.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<TodoEntry> _todos = [];
  late final AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final entry = TodoEntry(label: text, createdAt: DateTime.now());
    _controller.clear();
    _todos.insert(0, entry);
    _listKey.currentState?.insertItem(0);
    setState(() {});
  }

  void _toggleComplete(int index) {
    final entry = _todos[index];
    _todos[index] = entry.copyWith(isCompleted: !entry.isCompleted);
    setState(() {});
  }

  void _handleClearCompleted() {
    if (_todos.where((todo) => todo.isCompleted).isEmpty) return;
    for (int i = _todos.length - 1; i >= 0; i--) {
      if (_todos[i].isCompleted) {
        final removed = _todos.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: TaskCard(entry: removed, onToggle: () {}),
          ),
          duration: const Duration(milliseconds: 350),
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackdrop(animation: _backgroundController),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(onClear: _handleClearCompleted, todos: _todos),
                  const SizedBox(height: 32),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: _todos.isEmpty
                          ? const EmptyState()
                          : AnimatedList(
                              key: _listKey,
                              padding: EdgeInsets.zero,
                              initialItemCount: _todos.length,
                              itemBuilder: (context, index, animation) {
                                final entry = _todos[index];
                                return SizeTransition(
                                  sizeFactor: animation,
                                  child: TaskCard(
                                    entry: entry,
                                    onToggle: () => _toggleComplete(index),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Composer(controller: _controller, onSubmit: _handleAdd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
