class Document {
  final String id;
  final String title;
  final String type;
  final String url;
  final String date;
  final String size;
  final String status;
  final String? description;
  final String uploadedBy;

  const Document({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    required this.date,
    required this.size,
    required this.status,
    this.description,
    required this.uploadedBy,
  });

  Document copyWith({
    String? id,
    String? title,
    String? type,
    String? url,
    String? date,
    String? size,
    String? status,
    String? description,
    String? uploadedBy,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      url: url ?? this.url,
      date: date ?? this.date,
      size: size ?? this.size,
      status: status ?? this.status,
      description: description ?? this.description,
      uploadedBy: uploadedBy ?? this.uploadedBy,
    );
  }
}