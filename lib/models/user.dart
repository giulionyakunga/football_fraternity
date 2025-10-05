enum UserRole { viewer, client, legalOfficer }

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final UserRole role;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    required this.role,
    required this.createdAt,
  });
}