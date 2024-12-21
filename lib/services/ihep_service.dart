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
}
