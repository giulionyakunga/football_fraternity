class Document {
  final int id;
  final int userId;
  final String title;
  final String documentType;
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String size;
  final String? description;
  final DateTime createdAt; 

  const Document({
    required this.id,
    required this.userId,
    required this.title,
    required this.documentType,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.description,
    required this.size,
    required this.createdAt,
  });

  Document copyWith({
    int? id,
    int? userId,
    String? title,
    String? documentType,
    String? fileName,
    String? fileType,
    String? fileUrl,
    String? description,
    String? size,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      documentType: documentType ?? this.documentType,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      description: description ?? this.description,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
    );
  }

   factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      title: json['title'] ?? '',
      documentType: json['document_type'] ?? '',
      fileName: json['file_name'] ?? '',
      fileType: json['file_type'] ?? '',
      fileUrl: json['file_url'] ?? '',
      description: json['description'] ?? '',
      size: json['size'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}