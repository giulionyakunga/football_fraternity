class Footballer {
  final int id;
  final String fullName;
  final String position;
  final String club;
  final String nationality;
  final int age;
  final String contractStatus;
  final DateTime? contractStart;
  final DateTime? contractEnd;
  final String salary;
  final String imageUrl;
  final DateTime? dateOfBirth;
  final String? preferredFoot;
  final double? height;
  final double? weight;
  final int matches;
  final int goals;
  final int assists;
  final double? rating;

  const Footballer({
    required this.id,
    required this.fullName,
    required this.position,
    required this.club,
    required this.nationality,
    required this.age,
    required this.contractStatus,
    required this.contractStart,
    required this.contractEnd,
    required this.salary,
    required this.imageUrl,
    this.dateOfBirth,
    this.preferredFoot,
    this.height,
    this.weight,
    required this.matches,
    required this.goals,
    required this.assists,
    required this.rating,
  });

  // Factory method to create a Footballer from JSON
  factory Footballer.fromJson(Map<String, dynamic> json) {
    return Footballer(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      position: json['position'] ?? '',
      club: json['club'] ?? '',
      nationality: json['nationality'] ?? '',
      age: (json['age'] ?? 0).toInt(),
      contractStatus: json['contract_status'] ?? '',
      contractStart: json['contract_start'] != null && json['contract_start'] != "" ? DateTime.parse(json['contract_start']) : null,
      contractEnd: json['contract_end'] != null && json['contract_end'] != "" ? DateTime.parse(json['contract_end']) : null,
      salary: json['salary'] ?? '--',
      imageUrl: json['image_url'] ?? '',
      dateOfBirth: json['date_of_birth'] != null && json['date_of_birth'] != "" ? DateTime.parse(json['date_of_birth']) : null,
      preferredFoot: json['preferred_foot'] ?? '',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      matches: (json['matches'] ?? 0).toInt(),
      goals: (json['goals'] ?? 0).toInt(),
      assists: (json['assists'] ?? 0).toInt(),
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}