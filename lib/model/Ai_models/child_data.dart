import 'mood_ranges.dart';
import 'activities.dart';
import 'progress.dart';
import 'support_recommendations.dart';

class ChildData {
  String mood;
  MoodRanges moodRanges;
  Activities activities;
  Progress progress;
  SupportRecommendations supportRecommendations;

  ChildData({
    required this.mood,
    required this.moodRanges,
    required this.activities,
    required this.progress,
    required this.supportRecommendations,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      mood: json['mood'],
      moodRanges: MoodRanges.fromJson(json['mood_ranges']),
      activities: Activities.fromJson(json['activities']),
      progress: Progress.fromJson(json['progress']),
      supportRecommendations:
          SupportRecommendations.fromJson(json['support_recommendations']),
    );
  }
}
