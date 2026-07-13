import 'dart:async';
import 'package:flutter/material.dart';

class ZabetTimerScreen extends StatefulWidget {
  const ZabetTimerScreen({super.key});

  @override
  State<ZabetTimerScreen> createState() => _ZabetTimerScreenState();
}

class _ZabetTimerScreenState extends State<ZabetTimerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- Timer Variables (التايمر التنازلي) ---
  Timer? _countdownTimer;
  int _remainingSeconds = 250; // 00:04:10
  bool _isTimerRunning = false;

  // --- Stopwatch Variables (الستوب ووتش) ---
  Timer? _stopwatchTimer;
  int _stopwatchMilliseconds = 164000; // 00:02:44 تقريباً
  bool _isStopwatchRunning = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _stopwatchTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  // --- Timer Logic ---
  void _startTimer() {
    setState(() => _isTimerRunning = true);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _stopTimer();
      }
    });
  }

  void _pauseTimer() {
    _countdownTimer?.cancel();
    setState(() => _isTimerRunning = false);
  }

  void _stopTimer() {
    _countdownTimer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _remainingSeconds = 250;
    });
  }

  String _formatTimerTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "00:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // --- Stopwatch Logic ---
  void _startStopwatch() {
    setState(() => _isStopwatchRunning = true);
    _stopwatchTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() => _stopwatchMilliseconds += 100);
    });
  }

  void _pauseStopwatch() {
    _stopwatchTimer?.cancel();
    setState(() => _isStopwatchRunning = false);
  }

  void _resetStopwatch() {
    _stopwatchTimer?.cancel();
    setState(() {
      _isStopwatchRunning = false;
      _stopwatchMilliseconds = 0;
    });
  }

  String _formatStopwatchTime(int ms) {
    int totalSec = ms ~/ 1000;
    int minutes = totalSec ~/ 60;
    int seconds = totalSec % 60;
    int centi = (ms % 1000) ~/ 10;
    return "00:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.$centi";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepOrange,
          tabs: const [
            Tab(text: "Timer"),
            Tab(text: "Stopwatch"),
          ],
        ),

          ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTimerView(),
          _buildStopwatchView(),
        ],
      ),
    );
  }

  Widget _buildTimerView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTimerTime(_remainingSeconds),
            style: const TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Interval : 1/4",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isTimerRunning ? _pauseTimer : _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isTimerRunning ? Colors.deepOrange : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  _isTimerRunning ? "PAUSE" : "START",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: _stopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  "RESET",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStopwatchView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatStopwatchTime(_stopwatchMilliseconds),
            style: const TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isStopwatchRunning ? _pauseStopwatch : _startStopwatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isStopwatchRunning ? Colors.deepOrange : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  _isStopwatchRunning ? "PAUSE" : "RESUME",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  "RESET",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}