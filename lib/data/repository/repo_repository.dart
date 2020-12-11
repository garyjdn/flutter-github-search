import 'package:dio/dio.dart';

import '../data.dart';
import '../../models/models.dart';

class RepoRepository {
  Future<List<Repo>> fetchData({query, page}) async {
    Dio _dio = Dio();

    RepoRest repoRest = RepoRest(_dio);

    List<Repo> repos = await repoRest.findDataByName(
      query: query, 
      page: page
    );
    return repos;
  }  
}