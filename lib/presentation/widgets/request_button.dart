import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/domain/blocs/mock_request/mock_request_bloc.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.amber,
      onPressed: () {
        context.read<MockRequestBloc>().add(MakeRequest());
      },
      child: const Text('Request to mock api'),
    );
  }
}
