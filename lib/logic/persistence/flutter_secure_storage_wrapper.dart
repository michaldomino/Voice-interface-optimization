import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageWrapper {
  static const String _REFRESH_TOKEN_KEY = 'refreshToken';

  late FlutterSecureStorage _flutterSecureStorage;

  FlutterSecureStorageWrapper() {
    _flutterSecureStorage = FlutterSecureStorage();
  }

  Future<String?> getRefreshToken() {
    return _flutterSecureStorage.read(key: _REFRESH_TOKEN_KEY);
  }

  Future setRefreshToken(String refreshToken) {
    return _flutterSecureStorage.write(
        key: _REFRESH_TOKEN_KEY, value: refreshToken);
  }

  Future deleteRefreshToken() {
    return _flutterSecureStorage.delete(key: _REFRESH_TOKEN_KEY);
  }
}
