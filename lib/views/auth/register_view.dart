import 'package:flutter/material.dart';
import 'package:haf_calc/views/auth/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(child: RegisterViewBody()),
        ),
      ),
    );
  }
}
