import 'package:ihep/models/metadata.dart';

class Paper {
  const Paper._({
    required this.created,
    required this.metadata,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper._(
      created: json['created'] as String? ?? '',
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
  }

  final String created;
  final Metadata metadata;

  String get id => metadata.articleId;
}
