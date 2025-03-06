class Progress {
  String happy;
  String sad;
  String angry;
  String nervous;
  String excited;
  String bored;
  String frustrated;
  String overwhelmed;

  Progress({
    required this.happy,
    required this.sad,
    required this.angry,
    required this.nervous,
    required this.excited,
    required this.bored,
    required this.frustrated,
    required this.overwhelmed,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      happy: json['happy'],
      sad: json['sad'],
      angry: json['angry'],
      nervous: json['nervous'],
      excited: json['excited'],
      bored: json['bored'],
      frustrated: json['frustrated'],
      overwhelmed: json['overwhelmed'],
    );
  }
}
