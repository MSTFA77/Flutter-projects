import 'package:flutter/material.dart';
import 'screens/stopwatch_screen.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const StopwatchScreen(),
      )
    ;
  }
}
