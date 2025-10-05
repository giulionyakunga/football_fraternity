class Footballer {
  final String id;
  final String name;
  final String position;
  final String club;
  final String nationality;
  final int age;
  final String contractStatus;
  final String imageUrl;
  final DateTime? dateOfBirth;
  final String? preferredFoot;
  final double? height;
  final double? weight;

  const Footballer({
    required this.id,
    required this.name,
    required this.position,
    required this.club,
    required this.nationality,
    required this.age,
    required this.contractStatus,
    required this.imageUrl,
    this.dateOfBirth,
    this.preferredFoot,
    this.height,
    this.weight,
  });
}