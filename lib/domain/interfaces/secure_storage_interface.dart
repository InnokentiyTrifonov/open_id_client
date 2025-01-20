abstract interface class SecureStorageInterface {
  Future<void> setAccessToken(String? accessToken);
  Future<String?> getAccessToken();
  Future<void> setIdToken(String? idToken);
  Future<String?> getIdToken();
  Future<void> setRefreshToken(String? refreshToken);
  Future<String?> getRefreshToken();
  Future<DateTime?> getAccessTokenExpirationDateTime();
  Future<void> setAccessTokenExpirationDateTime(DateTime? date);
  Future<void> deleteAll();
}
