import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_id/domain/blocs/authentification/authentification_bloc.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationBloc, AuthentificationState>(
      listener: (context, state) {
        if (state is Authorized) context.replace('/home_page');
      },
      child: MaterialButton(
        onPressed: () {
          context.read<AuthentificationBloc>().add(SignIn());
        },
        color: Colors.amber,
        child: const Text('log in'),
      ),
    );
  }
}
