class Appointment {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String status;
  final String legalOfficerId;
  final String clientId;

  const Appointment({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
    required this.legalOfficerId,
    required this.clientId,
  });
}