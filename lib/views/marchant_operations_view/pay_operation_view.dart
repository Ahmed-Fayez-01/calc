import 'package:flutter/material.dart';
import 'package:haf_calc/views/marchant_operations_view/widgets/give_operation_view_body.dart';

class PayOperationView extends StatelessWidget {
  const PayOperationView({super.key,required this.merchantId,required this.merchantName});
  final String merchantId;
  final String merchantName;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: GiveOperationViewBody(merchantId: merchantId, merchantName: merchantName,),
        ),
      ),
    );
  }
}
