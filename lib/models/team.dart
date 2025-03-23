class Team {
  final String name;
  final String position;
  final String logo;

  Team({required this.name, required this.position, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      position: json['position'],
      logo: json['logo'],
    );
  }
}
