import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../widgets/stopwatch_display.dart';
import '../widgets/stopwatch_controls.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late Ticker _ticker;
  final Stopwatch _stopwatch = Stopwatch();

  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  final List<Duration> _laps = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _ticker = createTicker((_) {
      if (_isRunning) {
        setState(() {
          _elapsed = _stopwatch.elapsed;
        });
      }
    });
  }

  // Start / Resume
  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _stopwatch.start();
    _ticker.start();
  }

  // Pause
  void _stopTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
    });

    _stopwatch.stop();
    _ticker.stop();
  }

  // Reset
  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _elapsed = Duration.zero;
      _laps.clear();
    });

    _stopwatch.reset();
    _ticker.stop();
  }

  // Add lap
  void _addLap() {
    if (!_isRunning) return;

    setState(() {
      _laps.add(_elapsed);
    });
  }

  // Handle app lifecycle (background / resume)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isRunning) {
      _stopTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          
          end: Alignment.topRight,
          colors: [Color(0xFF1A349A),Color.fromRGBO(221, 200, 200, 0.434), Color.fromARGB(193, 77, 29, 149),Color.fromRGBO(221, 200, 200, 0.533), Color(0xFF7A003C)],
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        appBar: AppBar(
          title: const Text('Stopwatch App',
              style: TextStyle(
                color: Color.fromRGBO(221, 200, 200, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const SizedBox(height: 100),
              StopwatchDisplay(elapsed: _elapsed),
              const SizedBox(height: 40),
              StopwatchControls(
                isRunning: _isRunning,
                onStart: _startTimer,
                onStop: _stopTimer,
                onReset: _resetTimer,
                onLap: _addLap,
              ),

              const SizedBox(height: 20),

      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: _laps.length,
            itemBuilder: (context, index) {
              final lapTime = _laps[index];

              return ListTile(
                leading: Text(
                  'Lap ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(221, 200, 200, 1),
                  ),
                ),

                trailing: Text(
                  formatDuration(lapTime),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(221, 200, 200, 1),
                  ),
                ),
              );
            },
          ),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}
