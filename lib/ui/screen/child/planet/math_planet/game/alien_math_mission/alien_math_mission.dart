// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garduationproject/bloc/game/alien_math_mission/alien_math_mission_cubit.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class AlienMathMissionScreen extends StatelessWidget {
  static const String routeName = 'AlienMathMission';
  const AlienMathMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MathCubit()..generateNewQuestion(),
      child: const AlienMathMissionView(),
    );
  }
}

class AlienMathMissionView extends StatefulWidget {
  const AlienMathMissionView({super.key});

  @override
  State<AlienMathMissionView> createState() => _AlienMathMissionViewState();
}

class _AlienMathMissionViewState extends State<AlienMathMissionView> {
  final TextEditingController answerController = TextEditingController();

  Future<void> saveMathScore(int score) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final parents = await FirebaseFirestore.instance.collection('Parent').get();
    for (var parent in parents.docs) {
      final children = await FirebaseFirestore.instance
          .collection('Parent')
          .doc(parent.id)
          .collection('Children')
          .get();

      for (var child in children.docs) {
        final childData = child.data();
        if (childData.containsKey('firstName')) {
          await FirebaseFirestore.instance
              .collection('Parent')
              .doc(parent.id)
              .collection('Children')
              .doc(child.id)
              .update({'mathScore': score});
          return;
        }
      }
    }
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10132A),
      body: SafeArea(
        child: BlocBuilder<MathCubit, MathState>(
          builder: (context, state) {
            final cubit = context.read<MathCubit>();

            if (state.isAnswered) {
              Future.microtask(() async {
                answerController.clear();

                if (state.isCorrect == true) {
                  await saveMathScore(state.score);
                }
              });
            }

            return Stack(
              children: [
                buildBackground(),
                buildTopBar(context, state, cubit),
                buildMathQuestion(state),
                buildDividers(),
                buildAnswerRow(context, state),
                buildSubmitButton(cubit),
                if (state.isAnswered) buildFeedbackOverlay(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blue,
              Color(0xffbab7bf),
              Color(0xFFfccfa1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }

  Widget buildTopBar(BuildContext context, MathState state, MathCubit cubit) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: Image.asset(AppAssets.timerCatFace, height: 32),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: LinearProgressIndicator(
                value: state.remainingTime / 15,
                minHeight: 24,
                backgroundColor: Colors.white,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                state.paused ? Icons.play_arrow : Icons.pause,
                color: Colors.black,
              ),
              onPressed: () {
                state.paused ? cubit.resumeTimer() : cubit.pauseTimer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMathQuestion(MathState state) {
    return Positioned(
      top: 165,
      left: 0,
      right: 0,
      child: Row(
        children: [
          const Spacer(flex: 1),
          Text(
            state.operator,
            style: const TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
              shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
            ),
          ),
          const Spacer(flex: 1),
          Column(
            children: [
              Text(
                state.leftOperand.toString(),
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                state.rightOperand.toString(),
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget buildDividers() {
    return const Stack(
      children: [
        Positioned(
          top: 200,
          bottom: 0,
          left: 10,
          right: 250,
          child: Divider(thickness: 4, color: Colors.white),
        ),
        Positioned(
          top: 200,
          bottom: 0,
          left: 250,
          right: 10,
          child: Divider(thickness: 4, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildAnswerRow(BuildContext context, MathState state) {
    final correctAnswer = state.correctAnswer.toString().padLeft(2, '0');
    final firstDigit = correctAnswer[0];

    return Positioned(
      bottom: 110,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDigitBox(firstDigit), // Show the first digit
          const SizedBox(width: 16),
          buildAnswerBox(context),
        ],
      ),
    );
  }

  Widget buildDigitBox(String digit) {
    return Container(
      width: 60,
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Center(
        child: Text(
          digit,
          style: const TextStyle(
              fontSize: 32, color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildAnswerBox(BuildContext context) {
    return Container(
      width: 60,
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: buildTextFormFiledAnswer(
        hintText: '?',
        onChanged: (val) => context.read<MathCubit>().updateUserInput(val),
        borderRadius: BorderRadius.circular(16),
        controller: answerController,
      ),
    );
  }

  Widget buildSubmitButton(MathCubit cubit) {
    return Positioned(
      bottom: 20,
      left: 80,
      right: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFB966),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        onPressed: () {
          cubit.checkAnswer();
        },
        child: const Text(
          'DONE',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'inter',
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget buildFeedbackOverlay(MathState state) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Text(
            state.isCorrect == true
                ? 'Correct!'
                : (state.isCorrect == false ? 'False!' : ''),
            style: TextStyle(
              color: state.isCorrect == true ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------ TextField Builder ------------------------

buildTextFormFiledAnswer({
  Widget? suffixIcon,
  String? hintText,
  BorderRadius? borderRadius,
  TextEditingController? controller,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return TextFormField(
    onChanged: onChanged,
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
    ),
  );
}
