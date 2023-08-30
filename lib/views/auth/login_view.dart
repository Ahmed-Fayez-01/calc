import 'package:flutter/material.dart';
import 'package:haf_calc/views/auth/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(child: LoginViewBody()),
        ),
      ),
    );
  }
}
