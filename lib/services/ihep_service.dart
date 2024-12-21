import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ihep/models/paper_data.dart';

import '../models/paper.dart';

class IHepApiService {
  const IHepApiService();

  static const _baseUrl = 'https://inspirehep.net/api';

  Future<List<PaperData>> fetchTopCitedPapers({
    required int size,
    required int page,
  }) async {
    final client = http.Client();
    try {
      final url = Uri.parse(
        '$_baseUrl/literature?fields=titles,authors.full_name&sort=mostcited&size=$size&page=$page&q=topcite 10',
      );

      final response = await client.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;

      final hits = data['hits'] as Map<String, dynamic>;

      final papers = (hits['hits'] as List<dynamic>)
          .map((e) => PaperData.fromJson(e as Map<String, dynamic>))
          .toList();

      return papers;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Paper> fetchSpecific(String id) async {
    final client = http.Client();

    try {
      final url = Uri.parse('$_baseUrl/literature/$id');

      final response = await client.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;

      final paper = Paper.fromJson(data);

      return paper;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> _fetchTotalCount(_RecordType recordType) async {
    final client = http.Client();

    try {
      final url =
          Uri.parse('$_baseUrl/${recordType.pathSegment}?fields=none&size=1');

      final response = await client.get(url);

      final data = (json.decode(response.body) as Map<String, dynamic>)['hits']
          as Map<String, dynamic>;

      final total = data['total'] as int;

      return total;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> fetchTotalPapersCount() =>
      _fetchTotalCount(_RecordType.literature);

  Future<int> fetchTotalAuthorsCount() => _fetchTotalCount(_RecordType.authors);

  Future<int> fetchTotalInstitutionsCount() =>
      _fetchTotalCount(_RecordType.institutions);

  Future<int> fetchTotalConferencesCount() =>
      _fetchTotalCount(_RecordType.conferences);
}

enum _RecordType {
  literature,
  authors,
  institutions,
  conferences;

  String get pathSegment => switch (this) {
        literature => 'literature',
        authors => 'authors',
        institutions => 'institutions',
        conferences => 'conferences',
      };
}
