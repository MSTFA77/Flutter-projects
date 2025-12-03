import 'package:flutter/material.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String threeDigits(int n) => n.toString().padLeft(3, '0');

  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));

  return '$minutes:$seconds.$milliseconds';
}

class StopwatchDisplay extends StatelessWidget {
  final Duration elapsed;

  const StopwatchDisplay({super.key, required this.elapsed});

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Text(
        formatDuration(elapsed),
        style: const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          fontFeatures: [FontFeature.tabularFigures()],
          color: Color.fromARGB(221, 200, 200, 200),
        ),
      ),
    );
  }
}
