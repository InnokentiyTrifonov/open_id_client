import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:open_id/domain/interfaces/secure_storage_interface.dart';

class SecureStorageService implements SecureStorageInterface {
  final FlutterSecureStorage _flutterSecureStorage;

  final _accessTokenKey = 'accessTokenKey';
  final _idTokenKey = 'idTokenKey';
  final _refreshTokenKey = 'refreshTokenKey';
  final _accessTokenExpirationDateTimeKey = 'accessTokenExpirationDateTimeKey';

  SecureStorageService({required FlutterSecureStorage flutterSecureStorage})
      : _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<void> setAccessToken(String? accessToken) {
    return _flutterSecureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return _flutterSecureStorage.read(key: _accessTokenKey);
  }

  @override
  Future<void> setIdToken(String? idToken) async {
    return _flutterSecureStorage.write(key: _idTokenKey, value: idToken);
  }

  @override
  Future<String?> getIdToken() async {
    return _flutterSecureStorage.read(key: _idTokenKey);
  }

  @override
  Future<void> setRefreshToken(String? refreshToken) {
    return _flutterSecureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _flutterSecureStorage.read(key: _refreshTokenKey);
  }

  @override
  Future<DateTime?> getAccessTokenExpirationDateTime() async {
    final result = await _flutterSecureStorage.read(key: _accessTokenExpirationDateTimeKey);
    if (result == null) result;
    return DateTime.parse(result!);
  }

  @override
  Future<void> setAccessTokenExpirationDateTime(DateTime? date) async {
    if (date == null) {
      log('date parametr is null');
      return;
    }
    return _flutterSecureStorage.write(key: _accessTokenExpirationDateTimeKey, value: date.toIso8601String());
  }

  @override
  Future<void> deleteAll() {
    return _flutterSecureStorage.deleteAll();
  }
}
