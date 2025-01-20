import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_id/core/locator/locator.dart';
import 'package:open_id/domain/interfaces/secure_storage_interface.dart';

class TokensInfo extends StatefulWidget {
  const TokensInfo({super.key});

  @override
  State<TokensInfo> createState() => _TokensInfoState();
}

class _TokensInfoState extends State<TokensInfo> {
  final storage = locator.get<SecureStorageInterface>();

  Future<void> info() async {
    final accessToken = await storage.getAccessToken();
    final idToken = await storage.getIdToken();
    final refreshToken = await storage.getRefreshToken();
    final accessTokenExpirationDateTime = await storage.getAccessTokenExpirationDateTime();

    log('access_token: $accessToken');
    log('id_token: $idToken');
    log('refresh_token: $refreshToken');
    log('accessTokenExpirationDateTime : ${accessTokenExpirationDateTime?.toIso8601String()}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: info,
      color: Colors.amber,
      child: const Text('tokens info'),
    );
  }
}
