class PaperData {
  const PaperData._({
    required this.id,
    required this.authors,
    required this.titles,
  });

  factory PaperData.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map<String, dynamic>;

    return PaperData._(
      id: json['id'] as String? ?? '',
      authors: (metadata['authors'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>)['full_name'] as String)
          .toList(),
      titles: (metadata['titles'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>)['title'] as String)
          .toList(),
    );
  }

  final String id;

  final List<String> authors;
  final List<String> titles;
}
