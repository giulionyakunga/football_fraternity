class LegalCase {
  final String id;
  final String title;
  final String description;
  final String status;
  final String clientId;
  final String clientName;
  final String legalOfficerId;
  final String legalOfficerName;
  final String priority;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LegalCase({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.clientId,
    required this.clientName,
    required this.legalOfficerId,
    required this.legalOfficerName,
    required this.priority,
    required this.createdAt,
    this.updatedAt,
  });

  // Add copyWith method
  LegalCase copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? clientId,
    String? clientName,
    String? legalOfficerId,
    String? legalOfficerName,
    String? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LegalCase(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      legalOfficerId: legalOfficerId ?? this.legalOfficerId,
      legalOfficerName: legalOfficerName ?? this.legalOfficerName,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}