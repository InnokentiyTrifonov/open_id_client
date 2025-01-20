import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_id/core/locator/locator.dart';
import 'package:open_id/domain/blocs/authentification/authentification_bloc.dart';
import 'package:open_id/domain/blocs/mock_request/mock_request_bloc.dart';
import 'package:open_id/domain/interfaces/authentification_interface.dart';
import 'package:open_id/domain/interfaces/mock_request_interface.dart';
import 'package:open_id/presentation/widgets/clear_session_button.dart';
import 'package:open_id/presentation/widgets/log_info_button.dart';
import 'package:open_id/presentation/widgets/request_button.dart';
import 'package:open_id/presentation/widgets/user_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthentificationInterface? authentificationService;

  @override
  void initState() {
    super.initState();
    authentificationService = locator.get<AuthentificationInterface>();
    authentificationService?.startPeriodicRefreshToken();
  }

  @override
  void dispose() {
    authentificationService?.disposePeriodicRefreshToken();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MockRequestBloc(mockRequestService: locator.get<MockRequestInterface>()),
      child: BlocListener<AuthentificationBloc, AuthentificationState>(
        listener: (context, state) {
          if (state is Unauthorized) context.replace('/login_page');
        },
        child: const Scaffold(
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserInfoWidget(),
              SizedBox(height: 8),
              TokensInfo(),
              RequestButton(),
              SignOutButton(),
            ],
          )),
        ),
      ),
    );
  }
}
