import 'dart:math';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/parent/gato_timer/gato_timer_service.dart';
import 'package:garduationproject/ui/screen/parent/home/home_parent.dart';
import 'package:garduationproject/ui/screen/parent/child_progress/child_progress.dart';

class GatoTimer extends StatefulWidget {
  const GatoTimer({super.key});
  static const String routeName = 'GatoTimer';

  @override
  State<GatoTimer> createState() => _GatoTimerState();
}

class _GatoTimerState extends State<GatoTimer> with WidgetsBindingObserver {
  final GatoTimerService gatoTimerService = GatoTimerService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!gatoTimerService.isRunning) {
      gatoTimerService.resetTimer(seconds: 600); 
      gatoTimerService.resumeTimer(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    gatoTimerService.pauseTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      gatoTimerService.pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      gatoTimerService.resumeTimer(context);
    }
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return AnimatedBuilder(
      animation: gatoTimerService.notifier,
      builder: (context, _) {
        double progress = gatoTimerService.secondsRemaining / 600;
        return Scaffold(
          backgroundColor: const Color(0xffE1EEFF),
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 60),
                  const Center(
                    child: Text(
                      "Gato Timer",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff113BA7),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: RoundedCircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.white,
                          // ignore: deprecated_member_use
                          valueColor: const Color(0xff113BA7).withOpacity(0.6),
                          terminalRadius: 5,
                        ),
                      ),
                      Text(
                        _formatTime(gatoTimerService.secondsRemaining),
                        style: const TextStyle(
                          color: Color(0xff5F81D5),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              Positioned(
                bottom: 30,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentRoute != HomeParent.routeName) {
                              Navigator.pushNamed(context, HomeParent.routeName);
                            }
                          },
                          child: Icon(
                            Icons.home,
                            size: 30,
                            color: currentRoute == HomeParent.routeName ? Colors.blue : Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.history,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (currentRoute != ChildProgressScreen.routeName) {
                              Navigator.pushNamed(context, ChildProgressScreen.routeName);
                            }
                          },
                          child: Icon(
                            Icons.settings,
                            size: 30,
                            color: currentRoute == ChildProgressScreen.routeName ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class RoundedCircularProgressIndicator extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Color valueColor;
  final double terminalRadius;

  const RoundedCircularProgressIndicator({
    super.key,
    required this.value,
    this.strokeWidth = 4.0,
    this.backgroundColor = Colors.grey,
    this.valueColor = Colors.blue,
    this.terminalRadius = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(250),
      painter: _RoundedCircularProgressPainter(
        value: value,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        valueColor: valueColor,
        terminalRadius: terminalRadius,
      ),
    );
  }
}

class _RoundedCircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Color valueColor;
  final double terminalRadius;

  _RoundedCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.valueColor,
    required this.terminalRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final sweepAngle = 2 * pi * value;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
