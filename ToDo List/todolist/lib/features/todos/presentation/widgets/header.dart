import 'package:flutter/material.dart';

import '../../../todos/domain/todo_entry.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.onClear, required this.todos});

  final VoidCallback onClear;
  final List<TodoEntry> todos;

  @override
  Widget build(BuildContext context) {
    final completed = todos.where((todo) => todo.isCompleted).length;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
 
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To-Do List',
            
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,

            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${todos.length} planned • $completed done',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: completed == 0 ? null : onClear,
                icon: const Icon(Icons.auto_fix_high, size: 18),
                label: const Text('Clear done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
