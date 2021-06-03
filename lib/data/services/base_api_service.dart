import 'dart:io';

import 'package:http/http.dart' as http;

abstract class BaseApiService {
  static const String _API_URL = 'aqueous-shelf-69777.herokuapp.com';

  Future<http.Response> postUnauthenticatedRequest(
      String jsonString, String unencodedPath) {
    Uri uri = Uri.https(_API_URL, unencodedPath);
    return http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
        body: jsonString);
  }

  Future<http.Response> getAuthenticatedRequest(
      String unencodedPath, accessToken) {
    Uri uri = Uri.https(_API_URL, unencodedPath);
    return http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    });
  }

  Future<http.Response> postAuthenticatedRequest(
      String jsonString, String unencodedPath, accessToken) {
    Uri uri = Uri.https(_API_URL, unencodedPath);
    return http.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonString,
    );
  }
}
