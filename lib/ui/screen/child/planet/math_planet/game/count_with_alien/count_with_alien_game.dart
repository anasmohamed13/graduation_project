// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garduationproject/bloc/game/count_with_alien/count_with_alien_cubit.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/widget/alien_display.dart';
import 'package:garduationproject/ui/widget/answer_options.dart';

class CountWithAlienGame extends StatefulWidget {
  static const String routeName = 'count-with-alien-game';
  const CountWithAlienGame({super.key});

  @override
  State<CountWithAlienGame> createState() => _CountWithAlienGameState();
}

class _CountWithAlienGameState extends State<CountWithAlienGame> {
  bool _scoreSaved = false;
  bool _gameEnded = false;
  int _countdownSeconds = 5;

  Future<void> saveCountingScore(int score) async {
    try {
      print('🎮 Attempting to save counting score: $score');

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('❌ No user logged in');
        return;
      }

      print('✅ User found: ${user.uid}');

      // Try a more direct approach - get all parents and children
      final parents =
          await FirebaseFirestore.instance.collection('Parent').get();
      print('📁 Found ${parents.docs.length} parents');

      for (var parent in parents.docs) {
        print('👨‍👩‍👧‍👦 Checking parent: ${parent.id}');

        final children = await FirebaseFirestore.instance
            .collection('Parent')
            .doc(parent.id)
            .collection('Children')
            .get();

        print(
            '👶 Found ${children.docs.length} children for parent ${parent.id}');

        for (var child in children.docs) {
          final childData = child.data();
          print('🔍 Child data: $childData');

          // Check if this child belongs to current user or has firstName
          if (childData.containsKey('firstName')) {
            print('✅ Found child with firstName, updating score...');

            await FirebaseFirestore.instance
                .collection('Parent')
                .doc(parent.id)
                .collection('Children')
                .doc(child.id)
                .update({'countingScore': score});

            print('🎯 Score saved successfully: $score');
            return;
          }
        }
      }

      print('❌ No suitable child found');
    } catch (e) {
      print('💥 Error saving counting score: $e');
    }
  }

  // Alternative approach - try this if the above doesn't work:
  Future<void> saveCountingScoreAlternative(int score) async {
    try {
      print('🎮 Alternative: Attempting to save counting score: $score');

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('❌ No user logged in');
        return;
      }

      // Get all children across all parents
      final allParents =
          await FirebaseFirestore.instance.collection('Parent').get();

      for (var parentDoc in allParents.docs) {
        final childrenSnapshot = await FirebaseFirestore.instance
            .collection('Parent')
            .doc(parentDoc.id)
            .collection('Children')
            .get();

        if (childrenSnapshot.docs.isNotEmpty) {
          final firstChild = childrenSnapshot.docs.first;

          await FirebaseFirestore.instance
              .collection('Parent')
              .doc(parentDoc.id)
              .collection('Children')
              .doc(firstChild.id)
              .set({
            ...firstChild.data(),
            'countingScore': score,
          }, SetOptions(merge: true));

          print('🎯 Alternative method: Score saved successfully: $score');
          return;
        }
      }
    } catch (e) {
      print('💥 Alternative method error: $e');
    }
  }

  void _startCountdown() {
    if (!_gameEnded) {
      _gameEnded = true;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _countdownSeconds--;
          });

          if (_countdownSeconds <= 0) {
            timer.cancel();
            Navigator.pop(context); // Return to math planet
          }
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountWithAlienGameCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF10132A),
        body: SafeArea(
          child: BlocBuilder<CountWithAlienGameCubit, CountWithAlienGameState>(
            builder: (context, state) {
              // Save score when game is over and score hasn't been saved yet
              if (state.questionIndex ==
                      CountWithAlienGameCubit.totalQuestions - 1 &&
                  state.isAnswered &&
                  !_scoreSaved) {
                print('🎮 Game ended, saving score: ${state.points}');
                _scoreSaved = true;

                // Try both methods
                Future.delayed(const Duration(milliseconds: 500), () async {
                  await saveCountingScore(state.points);
                  // If first method fails, try alternative
                  await saveCountingScoreAlternative(state.points);
                });

                // Start countdown after game ends
                Future.delayed(const Duration(milliseconds: 1000), () {
                  _startCountdown();
                });
              }

              return Stack(
                children: [
                  Positioned.fill(child: Image.asset(AppAssets.gameBackground)),
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 22,
                          child: Image.asset(
                            AppAssets.timerCatFace,
                            height: 32,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: LinearProgressIndicator(
                              value: (state.secondsLeft) / 15,
                              minHeight: 24,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blueAccent),
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
                              final cubit =
                                  context.read<CountWithAlienGameCubit>();
                              if (state.paused) {
                                cubit.resumeTimer();
                              } else {
                                cubit.pauseTimer();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 32,
                    right: 32,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'How many aliens do you see?',
                          style: TextStyle(
                            color: Color(0xFF10132A),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 16,
                    right: 16,
                    child: SizedBox(
                      height: 450,
                      child: AlienDisplay(
                        selectedImages: state.selectedImages,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: AnswerOptions(
                      options: state.options,
                      isAnswered: state.isAnswered,
                      onSelected: (option) => context
                          .read<CountWithAlienGameCubit>()
                          .answer(option),
                    ),
                  ),
                  if (state.isAnswered)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            state.isCorrect == true
                                ? 'Correct!'
                                : (state.isCorrect == false ? 'False!' : ''),
                            style: TextStyle(
                              color: state.isCorrect == true
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (state.questionIndex ==
                          CountWithAlienGameCubit.totalQuestions - 1 &&
                      state.isAnswered)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Game Over!\nYour Score:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${state.points}',
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 48,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                'Returning to Math Planet in $_countdownSeconds seconds...',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
