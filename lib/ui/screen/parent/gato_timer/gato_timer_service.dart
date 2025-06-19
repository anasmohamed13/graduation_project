import 'dart:async';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/home/splash/child_splash.dart';

class GatoTimerService {
  static final GatoTimerService _instance = GatoTimerService._internal();

  factory GatoTimerService() => _instance;

  GatoTimerService._internal() {
    notifier = ValueNotifier<int>(_secondsRemaining);
  }

  Timer? _timer;
  int _secondsRemaining = 10800;
  bool _isRunning = false;

  late final ValueNotifier<int> notifier;

  int get secondsRemaining => _secondsRemaining;
  bool get isRunning => _isRunning;

  void startTimer(BuildContext context) {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsRemaining--;
      notifier.value = _secondsRemaining;

      if (_secondsRemaining <= 0) {
        _timer?.cancel();
        _isRunning = false;

        Future.delayed(Duration.zero, () {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ChildSplash()),
              (route) => false,
            );
          }
        });
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void resumeTimer(BuildContext context) {
    if (!_isRunning) {
      startTimer(context);
    }
  }

  void resetTimer({int seconds = 10800}) {
    _timer?.cancel();
    _secondsRemaining = seconds;
    notifier.value = _secondsRemaining;
    _isRunning = false;
  }
}
