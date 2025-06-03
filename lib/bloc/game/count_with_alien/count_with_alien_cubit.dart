import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class CountWithAlienGameState {
  final int questionIndex;
  final int aliensCount;
  final List<int> options;
  final int secondsLeft;
  final bool isAnswered;
  final bool? isCorrect;
  final int points;
  final bool paused;
  final List<String> selectedImages; // قائمة الصور المختارة للسؤال الحالي

  CountWithAlienGameState({
    required this.questionIndex,
    required this.aliensCount,
    required this.options,
    required this.secondsLeft,
    required this.isAnswered,
    required this.isCorrect,
    required this.points,
    required this.selectedImages,
    this.paused = false,
  });

  CountWithAlienGameState copyWith(
      {int? questionIndex,
      int? aliensCount,
      List<int>? options,
      int? secondsLeft,
      bool? isAnswered,
      bool? isCorrect,
      int? points,
      bool? paused,
      List<String>? selectedImages}) {
    return CountWithAlienGameState(
      questionIndex: questionIndex ?? this.questionIndex,
      aliensCount: aliensCount ?? this.aliensCount,
      options: options ?? this.options,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
      points: points ?? this.points,
      paused: paused ?? this.paused,
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

class CountWithAlienGameCubit extends Cubit<CountWithAlienGameState> {
  static const int totalQuestions = 6;
  static const int maxPoints = 30;
  static const int penalty = 5;
  static const int timePerQuestion = 15;

  final Random random = Random();

  // نطاق عدد الصور (من 1 إلى 8)
  static const int minAliens = 1;
  static const int maxAliens = 10;

  Timer? timer;

  CountWithAlienGameCubit()
      : super(CountWithAlienGameState(
          questionIndex: 0,
          aliensCount: 1,
          options: [1, 2, 3, 4],
          secondsLeft: timePerQuestion,
          isAnswered: false,
          isCorrect: null,
          points: maxPoints,
          selectedImages: [],
        )) {
    startQuestion(0);
  }

  void startQuestion(int index) {
    final aliens = random.nextInt(maxAliens - minAliens + 1) + minAliens;
    final options = generateOptions(aliens);

    final selectedImages = generateRandomImages(aliens);

    emit(state.copyWith(
      questionIndex: index,
      aliensCount: aliens,
      options: options,
      secondsLeft: timePerQuestion,
      isAnswered: false,
      isCorrect: null,
      selectedImages: selectedImages,
    ));
    startTimer();
  }

  List<String> generateRandomImages(int count) {
    final availableImagePaths = [
      AppAssets.alienOnPlane,
      AppAssets.alienRocket,
      AppAssets.planeOfAlien,
    ];

    List<String> images = [];
    for (int i = 0; i < count; i++) {
      images
          .add(availableImagePaths[random.nextInt(availableImagePaths.length)]);
    }
    return images;
  }

  List<int> generateOptions(int correct) {
    final options = <int>{correct};

    while (options.length < 4) {
      int wrongOption;
      do {
        wrongOption = random.nextInt(maxAliens - minAliens + 1) + minAliens;
      } while (options.contains(wrongOption));

      options.add(wrongOption);
    }

    final list = options.toList()..shuffle();
    return list;
  }

  void startTimer() {
    if (state.paused) return;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft > 1) {
        emit(state.copyWith(secondsLeft: state.secondsLeft - 1));
      } else {
        timer.cancel();
        onAnswer(null);
      }
    });
  }

  void answer(int selected) {
    // Prevent answering when game is paused or already answered
    if (state.isAnswered || state.paused) return;
    timer?.cancel();
    onAnswer(selected);
  }

  void onAnswer(int? selected) {
    final correct = selected == state.aliensCount;
    int newPoints = state.points;
    if (!correct) newPoints -= penalty;

    emit(state.copyWith(
      isAnswered: true,
      isCorrect: selected == null ? false : correct,
      points: newPoints,
    ));

    Future.delayed(const Duration(seconds: 1), nextQuestion);
  }

  void nextQuestion() {
    if (state.questionIndex + 1 < totalQuestions) {
      startQuestion(state.questionIndex + 1);
    } else {
      timer?.cancel();

      emit(state.copyWith(isAnswered: true));
    }
  }

  void pauseTimer() {
    timer?.cancel();
    emit(state.copyWith(paused: true));
  }

  void resumeTimer() {
    if (!state.paused) return;
    emit(state.copyWith(paused: false));
    startTimer();
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
