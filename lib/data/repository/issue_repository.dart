import 'package:dio/dio.dart';

import '../data.dart';
import '../../models/models.dart';

class IssueRepository {
  Future<List<Issue>> fetchData({query, page}) async {
    Dio _dio = Dio();

    IssueRest issueRest = IssueRest(_dio);

    List<Issue> issues = await issueRest.findDataByTitle(
      query: query,
      page: page,
    );
    return issues;
  }  
}