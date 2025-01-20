import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/domain/interfaces/authentification_interface.dart';
import 'package:open_id/domain/interfaces/secure_storage_interface.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc extends Bloc<AuthentificationEvent, AuthentificationState> {
  final SecureStorageInterface storage;
  final AuthentificationInterface authentificationService;

  AuthentificationBloc({required this.storage, required this.authentificationService})
      : super(AuthentificationInitial()) {
    on<CheckAuthentificationStatus>((event, emit) async {
      final accessToken = await storage.getAccessToken();
      if (accessToken == null) {
        emit(Unauthorized());
        return;
      }
      final accessTokenExpirationDateTime = await storage.getAccessTokenExpirationDateTime();
      if (accessTokenExpirationDateTime == null || accessTokenExpirationDateTime.isBefore(DateTime.now())) {
        emit(Unauthorized());
        return;
      }

      emit(Authorized());
    });

    on<SignIn>((event, emit) async {
      try {
        final result = await authentificationService.signInWithAutoCodeExchange();
        if (result == null) {
          emit(Unauthorized());
          return;
        }
        storage.setAccessToken(result.accessToken);
        storage.setAccessTokenExpirationDateTime(result.accessTokenExpirationDateTime);
        storage.setIdToken(result.idToken);
        storage.setRefreshToken(result.refreshToken);
        emit(Authorized());
      } catch (e) {
        log('', error: e);
      }
    });

    on<SignOut>((event, emit) async {
      try {
        final idToken = await storage.getIdToken();
        await authentificationService.clearSession(idToken: idToken);

        await storage.deleteAll();
        emit(Unauthorized());
      } catch (e) {
        log('', error: e);
      }
    });
  }
}
