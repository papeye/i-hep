import 'package:ihep/models/metadata.dart';

class Paper {
  const Paper._({
    required this.id,
    required this.created,
    required this.metadata,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper._(
      id: json['id'] as String? ?? '',
      created: json['created'] as String? ?? '',
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }

  final String created;
  final Metadata metadata;
  final String id;

  String get title => metadata.title;
}
