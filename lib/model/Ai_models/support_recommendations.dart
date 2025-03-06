class SupportRecommendations {
  String happy;
  String sad;
  String angry;
  String nervous;
  String excited;
  String bored;
  String frustrated;
  String overwhelmed;

  SupportRecommendations({
    required this.happy,
    required this.sad,
    required this.angry,
    required this.nervous,
    required this.excited,
    required this.bored,
    required this.frustrated,
    required this.overwhelmed,
  });

  factory SupportRecommendations.fromJson(Map<String, dynamic> json) {
    return SupportRecommendations(
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
