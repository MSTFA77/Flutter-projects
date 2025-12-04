import 'package:flutter/material.dart';

import '../../../todos/domain/todo_entry.dart';
import 'time_chip.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.entry, required this.onToggle});

  final TodoEntry entry;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final gradient = entry.isCompleted
        ? const LinearGradient(colors: [Color(0xFF1FD1A5), Color(0xFF28C76F)])
        : const LinearGradient(
            colors: [Color(0xFF2C2F4A), Color(0xFF202230)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: entry.isCompleted
                    ? const Color(0x4028C76F)
                    : const Color.fromRGBO(0, 0, 0, 0.35),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 0.6),
                    width: 1.6,
                  ),
                  color: entry.isCompleted
                      ? const Color.fromRGBO(255, 255, 255, 0.2)
                      : Colors.transparent,
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: entry.isCompleted ? 1 : 0,
                  child: const Icon(Icons.check, size: 18),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    decoration: entry.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2,
                    decorationColor: Colors.white70,
                  ),
                  child: Text(entry.label),
                ),
              ),
              const SizedBox(width: 12),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: entry.isCompleted ? 1 : 0.8,
                child: TimeChip(datetime: entry.createdAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
