import 'package:ihep/models/paper.dart';
import 'package:ihep/services/ihep_service.dart';

class PapersRepository {
  const PapersRepository({required IHepApiService apiService})
      : _apiService = apiService;
  final IHepApiService _apiService;

  Future<List<Paper>> getTopCitedPapers({
    int size = 10,
    int page = 1,
  }) =>
      _apiService.fetchTopCitedPapers(
        size: size,
        page: page,
      );

  Future<Paper> getSpecificPaper(String id) => _apiService.fetchSpecific(id);
}
