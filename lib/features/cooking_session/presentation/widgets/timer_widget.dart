import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final int durationMinutes;

  const TimerWidget({super.key, required this.durationMinutes});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationMinutes * 60;
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer.cancel();
        setState(() => _isRunning = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Time\'s up!')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = (_remainingSeconds % 60).floor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$minutes:${seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: _isRunning
              ? () => {_timer.cancel(), setState(() => _isRunning = false)}
              : _startTimer,
          child: Text(_isRunning ? 'Stop' : 'Start'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
