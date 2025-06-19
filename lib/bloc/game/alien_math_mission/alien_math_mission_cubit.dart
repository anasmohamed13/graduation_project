import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

// ------------------------ Math Cubit ------------------------

class MathCubit extends Cubit<MathState> {
  MathCubit()
      : super(MathState(
          leftOperand: 0,
          rightOperand: 0,
          operator: '+',
          correctAnswer: 0,
          userInput: '',
          score: 0,
          isAnswered: false,
          isCorrect: null,
          remainingTime: 15,
          paused: false,
          firstDigit: '',
          questionCount: 0,
          isGameComplete: false,
        ));

  Timer? _timer;

  void generateNewQuestion() {
    if (state.questionCount >= 6) {
      emit(state.copyWith(isGameComplete: true));
      return;
    }

    final random = Random();
    int left, right, result;
    String operator;

    // تأكد أن الناتج مكوّن من رقمين فقط (10 إلى 99)
    do {
      left = random.nextInt(50) + 1;
      right = random.nextInt(50) + 1;
      operator = ['+', '-'][random.nextInt(2)];
      result = operator == '+' ? left + right : left - right;
    } while (result < 10 || result > 99);

    emit(state.copyWith(
      leftOperand: left,
      rightOperand: right,
      operator: operator,
      correctAnswer: result,
      userInput: '',
      isAnswered: false,
      isCorrect: null,
      firstDigit: result.toString()[0],
      remainingTime: 15,
      questionCount: state.questionCount + 1,
    ));

    _startTimer();
  }

  void updateUserInput(String input) {
    emit(state.copyWith(userInput: input));
  }

  void checkAnswer() {
    if (state.userInput.isEmpty || state.userInput.length > 1) return;

    final fullAnswer = '${state.firstDigit}${state.userInput}';
    final isCorrect = int.tryParse(fullAnswer) == state.correctAnswer;

    emit(state.copyWith(
      isCorrect: isCorrect,
      isAnswered: true,
      score: isCorrect ? state.score + 1 : state.score,
    ));

    _timer?.cancel();

    Future.delayed(const Duration(seconds: 2), () {
      generateNewQuestion();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.paused) return;

      if (state.remainingTime <= 1) {
        timer.cancel();
        emit(state.copyWith(isAnswered: true, isCorrect: false));
        Future.delayed(const Duration(seconds: 2), () {
          generateNewQuestion();
        });
      } else {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      }
    });
  }

  void pauseTimer() {
    emit(state.copyWith(paused: true));
  }

  void resumeTimer() {
    emit(state.copyWith(paused: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

// ------------------------ Math State ------------------------

class MathState {
  final int leftOperand;
  final int rightOperand;
  final String operator;
  final int correctAnswer;
  final String userInput;
  final int score;
  final bool isAnswered;
  final bool? isCorrect;
  final int remainingTime;
  final bool paused;
  final String firstDigit;
  final int questionCount;
  final bool isGameComplete;

  MathState({
    required this.leftOperand,
    required this.rightOperand,
    required this.operator,
    required this.correctAnswer,
    required this.userInput,
    required this.score,
    required this.isAnswered,
    required this.isCorrect,
    required this.remainingTime,
    required this.paused,
    required this.firstDigit,
    required this.questionCount,
    required this.isGameComplete,
  });

  MathState copyWith({
    int? leftOperand,
    int? rightOperand,
    String? operator,
    int? correctAnswer,
    String? userInput,
    int? score,
    bool? isAnswered,
    bool? isCorrect,
    int? remainingTime,
    bool? paused,
    String? firstDigit,
    int? questionCount,
    bool? isGameComplete,
  }) {
    return MathState(
      leftOperand: leftOperand ?? this.leftOperand,
      rightOperand: rightOperand ?? this.rightOperand,
      operator: operator ?? this.operator,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      userInput: userInput ?? this.userInput,
      score: score ?? this.score,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect,
      remainingTime: remainingTime ?? this.remainingTime,
      paused: paused ?? this.paused,
      firstDigit: firstDigit ?? this.firstDigit,
      questionCount: questionCount ?? this.questionCount,
      isGameComplete: isGameComplete ?? this.isGameComplete,
    );
  }
}
