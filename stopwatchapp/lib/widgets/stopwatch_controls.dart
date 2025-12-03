import 'package:flutter/material.dart';

class StopwatchControls extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;
  final VoidCallback onLap;

  const StopwatchControls({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onStop,
    required this.onReset,
    required this.onLap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Start / Stop Button
        ElevatedButton(
          onPressed: isRunning ? onStop : onStart,
          style: ElevatedButton.styleFrom(
            backgroundColor: isRunning ? Colors.red : Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isRunning ? Icons.pause : Icons.play_arrow , size: 50,),
              
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Lap Button (only when running)
        if (isRunning)
          ElevatedButton(
            onPressed: onLap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 5,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag, size:50,),
        
              ],
            ),
          ),

        const SizedBox(width: 16),

        // Reset Button
        ElevatedButton(
          onPressed: onReset,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 5,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh , size:50,),
              
              
            ],
          ),
        ),
      ],
    );
  }
}
