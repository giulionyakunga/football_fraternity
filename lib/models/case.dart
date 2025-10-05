class LegalCase {
  final String id;
  final String title;
  final String description;
  final String status;
  final String clientId;
  final String legalOfficerId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const LegalCase({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.clientId,
    required this.legalOfficerId,
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
    String? legalOfficerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LegalCase(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      clientId: clientId ?? this.clientId,
      legalOfficerId: legalOfficerId ?? this.legalOfficerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}