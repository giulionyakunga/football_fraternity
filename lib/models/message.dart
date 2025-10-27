class Message {
  final int id;
  final String clientName;
  final String email;
  final String phoneNumber;
  final String text;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.clientName,
    required this.email,
    required this.phoneNumber,
    required this.text,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  // Add copyWith method
  Message copyWith({
    int? id,
    String? clientName,
    String? email,
    String? phoneNumber,
    String? text,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      text: text ?? this.text,
      type: text ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

    // Factory method to create a Footballer from JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? 0,
      clientName: json['client_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      text: json['text'] ?? '',
      type: json['type'] ?? 'incoming',
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}