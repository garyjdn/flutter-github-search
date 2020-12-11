import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../models/models.dart';

class IssueRest {
  Dio _dio;

  IssueRest(this._dio);

  Future<dynamic> createData() async {}

  Future<dynamic> readData() async{}

  Future<dynamic> updateData() async {}

  Future<dynamic> deleteData() async {}

  Future<List<Issue>> findDataByTitle({
    @required String query,
    int page
  }) async {
    assert(query != null);

    Response response = await _dio.get(
      "https://api.github.com/search/issues",
      queryParameters: {
        "q": query,
        "page": page,
      }
    );
    var responseData = response.data;
    List<Issue> issues = List<Issue>.from(responseData['items'].map((json) {
      return Issue.fromJson(json);
    }));
    // .toList();

    return issues;
  }
}