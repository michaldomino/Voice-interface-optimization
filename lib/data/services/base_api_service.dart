import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseApiService {
  static const String _API_URL = 'aqueous-shelf-69777.herokuapp.com';

  Future<http.Response> postPublicRequest(
      Map<String, dynamic> jsonMap, String unencodedPath) {
    String jsonString = json.encode(jsonMap);
    Uri uri = Uri.https(_API_URL, unencodedPath);
    return http.post(uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonString);
  }

  Future<http.Response> getPrivateRequest(
      String unencodedPath, accessToken) {
    Uri uri = Uri.https(_API_URL, unencodedPath);
    return http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Bearer Token': accessToken,
    });
  }
}
