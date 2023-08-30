import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haf_calc/views/home_view/home_vew.dart';
import 'package:haf_calc/views/splash/widgets/custom_loading_indicator.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3600), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: const Color(0xFF2B3396),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
            width: 150,
          ),
          const Text("اولاد الشيخ",
            style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          const SizedBox(
            height: 250,
          ),
          CustomLoadingIndicator(),
          const SizedBox(
            height: 55,
          ),
        ],
      ),
    );
  }
}
