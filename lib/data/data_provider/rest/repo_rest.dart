import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../models/models.dart';

class RepoRest {
  Dio _dio;

  RepoRest(this._dio);

  Future<dynamic> createData() async {}

  Future<dynamic> readData() async {}

  Future<dynamic> updateData() async {}

  Future<dynamic> deleteData() async {}

  Future<List<Repo>> findDataByName({
    @required String query,
    int page
  }) async {
    assert(query != null);

    Response response = await _dio.get(
      "https://api.github.com/search/repositories",
      queryParameters: {
        "q": query,
        "page": page,
      }
    );

    var responseData = response.data;
    List<Repo> repos = List<Repo>.from(responseData['items'].map((json) {
      return Repo.fromJson(json);
    }));

    return repos;
  }
}