abstract class BaseService {
  Future get({required String url, Map<String, dynamic>? params});
  Future put({required String url, required Map<String, dynamic> request});
  Future post({required String url, required Map<String, dynamic> request});
  Future delete({required String url, required Map<String, dynamic> request});
  Future multipartPost({required String url, Map<String, dynamic>? fields, Map<String, List<String>>? files, Map<String, dynamic>? params});
}
