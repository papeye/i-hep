import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ihep/models/paper_data.dart';

import '../models/paper.dart';

class IHepApiService {
  const IHepApiService();

  static const _baseUrl = 'https://inspirehep.net/api';

  Uri _parseForPaperData({
    required int size,
    int page = 1,
    required String sort,
    String? query,
  }) =>
      Uri.parse(
        '$_baseUrl/literature?sort=$sort&fields=titles,authors.full_name&size=$size&page=$page&q=${query ?? ''}',
      );

  Future<List<PaperData>> _fetchPaperData({
    required String sort,
    required int size,
    int page = 1,
    String? query,
  }) async {
    final client = http.Client();
    try {
      final url = _parseForPaperData(
          size: size, sort: 'mostrecent', page: page, query: query);

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

  Future<List<PaperData>> fetchMostRecentPapers(
    int size,
    int page,
  ) =>
      _fetchPaperData(sort: 'mostrecent', size: size, page: page);

  Future<List<PaperData>> fetchTopCitedPapers1({
    required int size,
    required int page,
  }) =>
      _fetchPaperData(
        sort: 'mostcited',
        size: size,
        page: page,
        query: 'topcite 1000+',
      );

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
