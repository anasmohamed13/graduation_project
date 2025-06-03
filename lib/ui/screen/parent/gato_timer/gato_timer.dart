import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GatoTimer extends StatefulWidget {
  const GatoTimer({super.key});
  static const String routeName = 'GatoTimer';

  @override
  State<GatoTimer> createState() => _GatoTimerState();
}

class _GatoTimerState extends State<GatoTimer> {
  Timer? _timer;
  int _secondsRemaining = 3 * 3600;
  bool _isRunning = false;
  String? _selectedButton;
  bool isAddHourButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _isRunning = false;
            _showTimeUpDialog();
        }
      });
    });
  }
  void _showTimeUpDialog() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Time's up!"),
      content: const Text("Do you want to add more time?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _addHour(); 
          },
          child: const Text("Yes +1 H"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
      ],
    ),
  );
}
 void _pauseTimer() {
  _timer?.cancel();
  _isRunning = false;
  setState(() {
    _selectedButton = 'no';   
  });
}

 void _addHour() {
    if (!isAddHourButtonVisible) return; 
  setState(() {
    _secondsRemaining += 3600;  
    _selectedButton = 'yes';    
    isAddHourButtonVisible = false; 
  });

  if (!_isRunning) {
    _startTimer(); 
    
  }
}

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progress = _secondsRemaining / (3 * 3600);
    return Scaffold(
      backgroundColor: const Color(0xffE1EEFF),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 37, left: 26, right: 26),
                child: Row(
                  children: [
                    Container(
                      width: 48.5,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Color(0xff113BA7), Color(0xff8EBFF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        "Gato Timer",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              SvgPicture.asset(
                'assets/image/Gatotimer.svg',
                width: 200,
                height: 200,
              ),
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
                      terminalRadius:
                          5, 
                    ),
                  ),
                  Text(
                    _formatTime(_secondsRemaining),
                    style: const TextStyle(
                      color: Color(0xff5F81D5),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Do you want to add time?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 isAddHourButtonVisible
    ? GestureDetector(
        onTap: _addHour,
        child: Container(
          width: 129,
          height: 48,
          decoration: BoxDecoration(
            color: _selectedButton == 'yes'
                ? const Color(0xff639FED)
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "Yes +1 H",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      )
    : const SizedBox(width: 129), 

                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _pauseTimer,
                    child: Container(
                      width: 129,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _selectedButton == 'no'
                            ? const Color(0xff639FED)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              )
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
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.home, size: 30, color: Colors.blue),
                    Icon(Icons.history, size: 30, color: Colors.black),
                    Icon(Icons.settings, size: 30, color: Colors.black),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RoundedCircularProgressIndicator extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Color valueColor;
  final double terminalRadius;

  // ignore: use_super_parameters
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
