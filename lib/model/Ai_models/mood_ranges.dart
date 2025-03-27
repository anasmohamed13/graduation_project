class MoodRanges {
  Map<String, Map<String, double>> ranges;

  MoodRanges({required this.ranges});

  factory MoodRanges.fromJson(Map<String, dynamic> json) {
    return MoodRanges(
      ranges: {
        'happy': Map<String, double>.from(json['happy']),
        'sad': Map<String, double>.from(json['sad']),
        'angry': Map<String, double>.from(json['angry']),
        'nervous': Map<String, double>.from(json['nervous']),
        'excited': Map<String, double>.from(json['excited']),
        'bored': Map<String, double>.from(json['bored']),
        'frustrated': Map<String, double>.from(json['frustrated']),
        'overwhelmed': Map<String, double>.from(json['overwhelmed']),
      },
    );
  }
  Map<String, dynamic> toJson() {
    return ranges;
  }
}
