import 'package:ihep/models/paper.dart';
import 'package:ihep/models/paper_data.dart';
import 'package:ihep/services/ihep_service.dart';

class PapersRepository {
  const PapersRepository({required IHepApiService apiService})
      : _apiService = apiService;
  final IHepApiService _apiService;

  Future<List<PaperData>> getTopCitedPapers({
    int size = 10,
    int page = 1,
  }) =>
      _apiService.fetchMostRecentPapers(size, page);

  Future<Paper> getSpecificPaper(String id) => _apiService.fetchSpecific(id);

  Future<int> getTotalPapersCount() => _apiService.fetchTotalPapersCount();

  Future<int> getTotalAuthorsCount() => _apiService.fetchTotalAuthorsCount();

  Future<int> getTotalInstitutionsCount() =>
      _apiService.fetchTotalInstitutionsCount();

  Future<int> getTotalConferencesCount() =>
      _apiService.fetchTotalConferencesCount();
}
