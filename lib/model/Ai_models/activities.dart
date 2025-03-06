class Activities {
  Map<String, Map<String, double>> educational;
  Map<String, double> social;
  Map<String, double> emotional;

  Activities({
    required this.educational,
    required this.social,
    required this.emotional,
  });

  factory Activities.fromJson(Map<String, dynamic> json) {
    return Activities(
      educational: {
        'math': Map<String, double>.from(json['educational']['math']),
        'science': Map<String, double>.from(json['educational']['science']),
        'art': Map<String, double>.from(json['educational']['art']),
      },
      social: Map<String, double>.from(json['social']),
      emotional: Map<String, double>.from(json['emotional']),
    );
  }
}
