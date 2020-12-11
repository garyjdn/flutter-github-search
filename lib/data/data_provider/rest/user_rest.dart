import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../models/models.dart';

class UserRest {
  Dio _dio;

  UserRest(this._dio);

  Future<dynamic> createData() async {}

  Future<dynamic> readData() async {}

  Future<dynamic> updateData() async {}

  Future<dynamic> deleteData() async {}

  Future<List<User>> findDataByUsername({
    @required String query, 
    int page
  }) async {
    assert(query != null);

    Response response = await _dio.get(
      "https://api.github.com/search/users",
      queryParameters: {
        "q": query,
        "page": page,
      }
    );

    var responseData = response.data;
    List<User> users = List<User>.from(responseData['items'].map((json) {
      return User.fromJson(json);
    }));

    return users;
  }
}