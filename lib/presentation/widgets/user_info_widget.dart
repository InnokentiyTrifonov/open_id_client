import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/domain/blocs/mock_request/mock_request_bloc.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MockRequestBloc, MockRequestState>(builder: (context, state) {
      if (state is RequestError) return Text(state.message);
      if (state is RequestSuccess) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.email),
            Text(state.familyName),
            Text(state.name),
          ],
        );
      }
      if (state is MockRequestInitial) return const Text('Try press on request button');
      return const SizedBox.shrink();
    });
  }
}
