import 'package:flutter/material.dart';

class TimeChip extends StatelessWidget {
  const TimeChip({super.key, required this.datetime});

  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(datetime);
    String label;
    if (difference.inMinutes < 1) {
      label = 'Just now';
    } else if (difference.inHours < 1) {
      label = '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      label = '${difference.inHours}h ago';
    } else {
      label = '${difference.inDays}d ago';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Colors.white70),
      ),
    );
  }
}
