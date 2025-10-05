class Service {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<String> features;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
  });

  Service copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    List<String>? features,
  }) {
    return Service(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      features: features ?? this.features,
    );
  }
}