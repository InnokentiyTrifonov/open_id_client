import 'package:open_id/domain/models/autorization_tokens_model.dart';

abstract interface class AuthentificationInterface {
  Future<AutorizationTokensModel?> signInWithAutoCodeExchange();
  void startPeriodicRefreshToken();
  void disposePeriodicRefreshToken();
  Future<String?> clearSession({required String? idToken});
}
