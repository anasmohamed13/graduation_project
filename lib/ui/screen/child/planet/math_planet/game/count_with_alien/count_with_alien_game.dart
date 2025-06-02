import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garduationproject/bloc/game/count_with_alien/count_with_alien_cubit.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:garduationproject/ui/widget/alien_display.dart';
import 'package:garduationproject/ui/widget/answer_options.dart';

class CountWithAlienGame extends StatelessWidget {
  static const String routeName = 'count-with-alien-game';
  const CountWithAlienGame({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountWithAlienGameCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF10132A),
        body: SafeArea(
          child: BlocBuilder<CountWithAlienGameCubit, CountWithAlienGameState>(
            builder: (context, state) {
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
                          child: Text(
                            'Game Over!\nYour Score: ${state.points}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
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
