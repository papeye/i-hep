import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/paper.dart';

class IHepApiService {
  const IHepApiService();

  static const _baseUrl = 'https://inspirehep.net/api';

  Future<List<Paper>> fetchTopCitedLiterature({
    int size = 10,
    int page = 1,
  }) async {
    final client = http.Client();
    try {
      final url = Uri.parse(
        '$_baseUrl/literature?sort=mostrecent&size=$size&page=$page&q=topcite 1000',
      );

      final response = await client.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;

      final hits = data['hits'] as Map<String, dynamic>;

      final papers = (hits['hits'] as List<dynamic>)
          .map((e) => Paper.fromJson(e as Map<String, dynamic>))
          .toList();

      return papers;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
