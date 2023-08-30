import 'package:flutter/material.dart';
import 'package:haf_calc/views/customer_operations_view/widgets/customer_view_body.dart';

import '../home_view/home_vew.dart';

class CustomerOperationsView extends StatelessWidget {
  const CustomerOperationsView({super.key,required this.userId,required this.userName});
  final String userId;
  final String userName;
  @override
  Widget build(BuildContext context) {

    return   SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: ()async{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
            return true;
          },
          child: Scaffold(
           body: CustomerViewBody(userId: userId,userName: userName,),
          ),
        ),
      ),
    );
  }
}
