abstract class HttpClientInterface {
  Future httpGet(String path, Map<String, dynamic> queryParameters);
  Future httpPost();
}