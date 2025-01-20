import 'package:flutter/material.dart';

import 'package:open_id/presentation/widgets/log_in_button.dart';
import 'package:open_id/presentation/widgets/welcome_text_widget.dart';

class AuthentificationScreen extends StatelessWidget {
  const AuthentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WelcomeTextWidget(),
            SizedBox(height: 8),
            LogInButton(),
          ],
        ),
      ),
    );
  }
}
