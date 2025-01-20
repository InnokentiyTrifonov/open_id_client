import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:open_id/core/network_client/network_client.dart';
import 'package:open_id/core/network_client/network_client_interceptor.dart';
import 'package:open_id/data/mock_requiest_service.dart';
import 'package:open_id/data/secure_storage.dart';
import 'package:open_id/data/authentification_service.dart';
import 'package:open_id/domain/interfaces/authentification_interface.dart';
import 'package:open_id/domain/interfaces/mock_request_interface.dart';
import 'package:open_id/domain/interfaces/secure_storage_interface.dart';

GetIt locator = GetIt.instance;

void configureLocator() {
  const flutterSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  final storage = SecureStorageService(flutterSecureStorage: flutterSecureStorage);

  final authentificationService = AuthentificationService(
    appAuth: const FlutterAppAuth(),
    secureStorageService: storage,
  );

  locator.registerSingleton<AuthentificationInterface>(authentificationService);
  locator.registerSingleton<SecureStorageInterface>(storage);
  locator.registerSingleton<MockRequestInterface>(
    MockRequestService(
      client: NetworkClient(
        baseUrl: 'https://demo.duendesoftware.com',
        dio: Dio(),
        interceptor: NetworkClientInterceptor(
          secureStorageService: SecureStorageService(
            flutterSecureStorage: flutterSecureStorage,
          ),
        ),
      ),
    ),
  );
}
