import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_id/domain/blocs/authentification/authentification_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationBloc, AuthentificationState>(
      listener: (context, state) {
        if (state is Authorized) context.replace('/home_page');
        if (state is Unauthorized) context.replace('/login_page');
      },
      child: const Scaffold(
        body: Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
