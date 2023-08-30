import 'package:flutter/material.dart';


class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/sub_logo.png",color: const Color(0xff2b3396),fit: BoxFit.cover,),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
