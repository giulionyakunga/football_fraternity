class Contract {
  final String id;
  final String footballerId;
  final String footballerName;
  final String club;
  final DateTime startDate;
  final DateTime endDate;
  final double salary;
  final String status;
  final List<String> terms;

  const Contract({
    required this.id,
    required this.footballerId,
    required this.footballerName,
    required this.club,
    required this.startDate,
    required this.endDate,
    required this.salary,
    required this.status,
    required this.terms,
  });

  // Add copyWith method
  Contract copyWith({
    String? id,
    String? footballerId,
    String? footballerName,
    String? club,
    DateTime? startDate,
    DateTime? endDate,
    double? salary,
    String? status,
    List<String>? terms,
  }) {
    return Contract(
      id: id ?? this.id,
      footballerId: footballerId ?? this.footballerId,
      footballerName: footballerName ?? this.footballerName,
      club: club ?? this.club,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      salary: salary ?? this.salary,
      status: status ?? this.status,
      terms: terms ?? this.terms,
    );
  }
}