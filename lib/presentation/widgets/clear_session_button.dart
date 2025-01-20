import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/domain/blocs/authentification/authentification_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        context.read<AuthentificationBloc>().add(SignOut());
      },
      color: Colors.amber,
      child: const Text('Sign out'),
    );
  }
}
