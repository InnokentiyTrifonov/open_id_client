import 'dart:async';
import 'dart:developer';

import 'package:open_id/data/secure_storage.dart';
import 'package:open_id/domain/interfaces/authentification_interface.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:open_id/domain/models/autorization_tokens_model.dart';

class AuthentificationService implements AuthentificationInterface {
  final FlutterAppAuth _appAuth;
  final SecureStorageService _secureStorageService;

  AuthentificationService({
    required FlutterAppAuth appAuth,
    required SecureStorageService secureStorageService,
  })  : _appAuth = appAuth,
        _secureStorageService = secureStorageService;

  final String _clientId = 'interactive.public';
  final String _redirectUrl = 'com.duendesoftware.demo:/oauthredirect';
  final String _issuer = 'https://demo.duendesoftware.com';
  final String _postLogoutRedirectUrl = 'com.duendesoftware.demo:/';
  final List<String> _scopes = <String>['openid', 'profile', 'email', 'offline_access', 'api'];

  final AuthorizationServiceConfiguration _serviceConfiguration = const AuthorizationServiceConfiguration(
    authorizationEndpoint: 'https://demo.duendesoftware.com/connect/authorize',
    tokenEndpoint: 'https://demo.duendesoftware.com/connect/token',
    endSessionEndpoint: 'https://demo.duendesoftware.com/connect/endsession',
  );

  @override
  Future<AutorizationTokensModel?> signInWithAutoCodeExchange() async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          externalUserAgent: ExternalUserAgent.asWebAuthenticationSession,
        ),
      );
      return AutorizationTokensModel(
        accessToken: result.accessToken,
        idToken: result.idToken,
        refreshToken: result.refreshToken,
        accessTokenExpirationDateTime: result.accessTokenExpirationDateTime,
      );
    } catch (e) {
      log('', error: e);
    }
    return null;
  }

  Future<TokenResponse> refresh({
    String? refreshToken,
  }) async {
    return _appAuth.token(TokenRequest(
      _clientId,
      _redirectUrl,
      refreshToken: refreshToken,
      issuer: _issuer,
      scopes: _scopes,
    ));
  }

  @override
  Future<String?> clearSession({String? idToken}) async {
    try {
      final result = await _appAuth.endSession(EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: _postLogoutRedirectUrl,
          serviceConfiguration: _serviceConfiguration,
          externalUserAgent: ExternalUserAgent.asWebAuthenticationSession));

      return result.state;
    } catch (e) {
      log('', error: e);
    }
    return null;
  }

  Timer? _timer;

  @override
  Future<void> startPeriodicRefreshToken() async {
    final refreshToken = await _secureStorageService.getRefreshToken();
    final result = await refresh(refreshToken: refreshToken);

    await _secureStorageService.setAccessToken(result.accessToken);
    await _secureStorageService.setAccessTokenExpirationDateTime(result.accessTokenExpirationDateTime);
    await _secureStorageService.setRefreshToken(result.refreshToken);
    await _secureStorageService.setIdToken(result.refreshToken);

    log('accessToken was updated next updating after 50 minutes');

    _timer = Timer.periodic(const Duration(minutes: 50), (Timer t) async {
      final refreshToken = await _secureStorageService.getRefreshToken();
      final result = await refresh(refreshToken: refreshToken);

      await _secureStorageService.setAccessToken(result.accessToken);
      log('accessToken was updated next updating after 50 minutes');
    });
  }

  @override
  void disposePeriodicRefreshToken() {
    _timer?.cancel();
  }
}
