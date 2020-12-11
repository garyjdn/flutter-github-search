import 'package:dio/dio.dart';
import './client.dart';

class DioClient implements HttpClientInterface {
  DioClient._privateConstructor();
  static final DioClient instance = DioClient._privateConstructor();


  Future httpGet(path, queryParameters) {
    
  }

  Future httpPost() {

  }
}