import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/core/locator/locator.dart';
import 'package:open_id/core/navigation/router.dart';
import 'package:open_id/domain/blocs/authentification/authentification_bloc.dart';
import 'package:open_id/domain/interfaces/authentification_interface.dart';
import 'package:open_id/domain/interfaces/secure_storage_interface.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthentificationBloc(
          storage: locator.get<SecureStorageInterface>(),
          authentificationService: locator.get<AuthentificationInterface>())
        ..add(CheckAuthentificationStatus()),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
