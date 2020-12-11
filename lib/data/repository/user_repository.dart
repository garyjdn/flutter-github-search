import 'package:dio/dio.dart';

import '../data.dart';
import '../../models/models.dart';

class UserRepository {
  Future<List<User>> fetchData({query, page}) async {
    Dio _dio = Dio();

    UserRest userRest = UserRest(_dio);

    List<User> users = await userRest.findDataByUsername(
      query: query, 
      page: page
    );
    return users;
  }  
}