import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

// ------------------------ Math Cubit ------------------------

enum AnswerPart { left, right }

class MathCubit extends Cubit<MathState> {
  Timer? _timer;
  bool _isPaused = false;

  MathCubit()
      : super(MathState(
          leftOperand: 0,
          rightOperand: 0,
          operator: '+',
          answer: 0,
          answerPart: AnswerPart.left,
          correctPart: 0,
          userInput: '',
          isAnswered: false,
          isCorrect: null,
          remainingTime: 15,
          score: 0,
          questionCount: 0,
          paused: false,
          quizFinished: false,
          firstDigit: '',
          secondDigit: '',
          prefillFirstDigit: true,
        ));

  void startNewQuiz() {
    emit(state.copyWith(
      score: 0,
      questionCount: 0,
      quizFinished: false,
    ));
    generateNewQuestion();
  }

  void generateNewQuestion() {
    if (state.quizFinished) return;
    _timer?.cancel();
    _isPaused = false;
    final rnd = Random();
    int a = rnd.nextInt(90) + 10;
    int b = rnd.nextInt(90) + 10;
    List<String> ops = ['+', '-', '×', '÷'];
    String op = ops[rnd.nextInt(ops.length)];
    int ans = 0;

    switch (op) {
      case '+':
        ans = a + b;
        break;
      case '-':
        ans = a - b;
        break;
      case '×':
        ans = a * b;
        break;
      case '÷':
        int attempts = 0;
        while (a % b != 0 && attempts < 100) {
          a = rnd.nextInt(90) + 10;
          b = rnd.nextInt(80) + 10;
          attempts++;
        }
        if (a % b != 0) {
          b = 10;
          a = b * (rnd.nextInt(9) + 1);
        }
        ans = a ~/ b;
        break;
    }

    String ansStr = ans.abs().toString().padLeft(2, '0');
    String firstDigit = ansStr[0];
    String secondDigit = ansStr[1];
    bool prefillFirstDigit = rnd.nextBool();

    final part = rnd.nextBool() ? AnswerPart.left : AnswerPart.right;
    final correctPart = part == AnswerPart.left ? a : b;

    emit(state.copyWith(
      leftOperand: a,
      rightOperand: b,
      operator: op,
      answer: ans,
      answerPart: part,
      correctPart: correctPart,
      userInput: '',
      isAnswered: false,
      isCorrect: null,
      remainingTime: 15,
      paused: false,
      firstDigit: firstDigit,
      secondDigit: secondDigit,
      prefillFirstDigit: prefillFirstDigit,
    ));

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return;
      if (state.remainingTime <= 1) {
        timer.cancel();
        emit(state.copyWith(isAnswered: true, isCorrect: false));
        Future.delayed(const Duration(seconds: 2), () {
          if (state.questionCount >= 4) {
            emit(state.copyWith(quizFinished: true, paused: true));
          } else {
            final newCount = state.questionCount + 1;
            emit(state.copyWith(questionCount: newCount));
            generateNewQuestion();
          }
        });
      } else {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      }
    });
  }

  void updateUserInput(String input) {
    final sanitizedInput = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitizedInput.length > 2) return;
    emit(state.copyWith(userInput: sanitizedInput));
  }

  void checkAnswer() {
    if (state.isAnswered || state.quizFinished) return;

    String userInput = state.userInput.trim();

    String answerToCheck = state.prefillFirstDigit
        ? state.firstDigit + userInput
        : userInput + state.secondDigit;

    bool correct = answerToCheck == (state.firstDigit + state.secondDigit);
    final newScore = correct ? state.score + 6 : state.score;

    emit(state.copyWith(isAnswered: true, isCorrect: correct, score: newScore));

    Future.delayed(const Duration(seconds: 2), () {
      if (state.questionCount >= 4) {
        emit(state.copyWith(quizFinished: true, paused: true));
      } else {
        final newCount = state.questionCount + 1;
        emit(state.copyWith(questionCount: newCount));
        generateNewQuestion();
      }
    });
  }

  void pauseTimer() {
    _isPaused = true;
    emit(state.copyWith(paused: true));
  }

  void resumeTimer() {
    _isPaused = false;
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
  final int answer;
  final AnswerPart answerPart;
  final int correctPart;
  final String userInput;
  final bool isAnswered;
  final bool? isCorrect;
  final int remainingTime;
  final int score;
  final int questionCount;
  final bool paused;
  final bool quizFinished;
  final String firstDigit;
  final String secondDigit;
  final bool prefillFirstDigit;

  MathState({
    required this.leftOperand,
    required this.rightOperand,
    required this.operator,
    required this.answer,
    required this.answerPart,
    required this.correctPart,
    required this.userInput,
    required this.isAnswered,
    required this.isCorrect,
    required this.remainingTime,
    required this.score,
    required this.questionCount,
    required this.paused,
    required this.quizFinished,
    required this.firstDigit,
    required this.secondDigit,
    required this.prefillFirstDigit,
  });

  MathState copyWith({
    int? leftOperand,
    int? rightOperand,
    String? operator,
    int? answer,
    AnswerPart? answerPart,
    int? correctPart,
    String? userInput,
    bool? isAnswered,
    bool? isCorrect,
    int? remainingTime,
    int? score,
    int? questionCount,
    bool? paused,
    bool? quizFinished,
    String? firstDigit,
    String? secondDigit,
    bool? prefillFirstDigit,
  }) {
    return MathState(
      leftOperand: leftOperand ?? this.leftOperand,
      rightOperand: rightOperand ?? this.rightOperand,
      operator: operator ?? this.operator,
      answer: answer ?? this.answer,
      answerPart: answerPart ?? this.answerPart,
      correctPart: correctPart ?? this.correctPart,
      userInput: userInput ?? this.userInput,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
      remainingTime: remainingTime ?? this.remainingTime,
      score: score ?? this.score,
      questionCount: questionCount ?? this.questionCount,
      paused: paused ?? this.paused,
      quizFinished: quizFinished ?? this.quizFinished,
      firstDigit: firstDigit ?? this.firstDigit,
      secondDigit: secondDigit ?? this.secondDigit,
      prefillFirstDigit: prefillFirstDigit ?? this.prefillFirstDigit,
    );
  }
}
