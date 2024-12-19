import 'package:ihep/models/author.dart';

class Metadata {
  const Metadata._({
    required this.authors,
    required this.citationCount,
    required this.journalTitle,
    required this.journalVolume,
    required this.articleId,
    required this.titles,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    final authors = (json['authors'] as List<dynamic>)
        .map((e) => Author.fromJson(e as Map<String, dynamic>))
        .toList();

    final titles = (json['titles'] as List<dynamic>)
        .map((e) => (e as Map<String, dynamic>)['title'] as String)
        .toList();

    return Metadata._(
      authors: authors,
      citationCount: json['citation_count'] as int? ?? 0,
      journalTitle: json['journal_title'] as String? ?? '',
      journalVolume: json['journal_volume'] as String? ?? '',
      articleId: json['artid'] as String? ?? '',
      titles: titles,
    );
  }

  final List<Author> authors;
  //final List<String> citations;  // TODO
  final int citationCount;
  final String journalTitle;
  final String journalVolume;
  final String articleId;
  final List<String> titles;
}
