class Author {
  const Author._({
    required this.fullName,
    required this.uuid,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author._(
      fullName: json['full_name'] as String? ?? '',
      uuid: json['uuid'] as String? ?? '',
    );
  }

  final String fullName;
  final String uuid;
}
