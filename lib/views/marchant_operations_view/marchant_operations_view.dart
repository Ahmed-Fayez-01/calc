import 'package:flutter/material.dart';
import 'package:haf_calc/views/marchant_operations_view/widgets/marchant_view_body.dart';

import '../home_view/home_vew.dart';

class MarchantOperationsView extends StatelessWidget {
  const MarchantOperationsView({super.key,required this.merchantId,required this.merchantName});
  final String merchantId;
  final String merchantName;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
          child:  Scaffold(
           body: MarchantViewBody(merchantId: merchantId, merchantName: merchantName,),
          ),
        ),
      ),
    );
  }
}
