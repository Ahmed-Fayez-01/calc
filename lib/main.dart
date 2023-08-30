import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/cubits/auth/register/register_cubit.dart';
import 'package:haf_calc/cubits/customer/customer_cubit.dart';
import 'package:haf_calc/cubits/marchant/marchant_cubit.dart';
import 'package:haf_calc/views/splash/splash.dart';

import 'cubits/auth/login/login_cubit.dart';
import 'cubits/transactions/transactions_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HafCalc());
}

class HafCalc extends StatelessWidget {
  const HafCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => CustomerCubit()),
        BlocProvider(create: (context) => MerchantCubit()),
        BlocProvider(create: (context) => TransactionsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Cairo"
        ),
        home:  const SplashScreen(),
        title: "اولاد الشيخ",
      ),
    );
  }
}