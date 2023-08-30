import 'package:flutter/material.dart';
import 'package:haf_calc/views/marchant_operations_view/widgets/take_operation_view_body.dart';

class BuyOperationView extends StatelessWidget {
  const BuyOperationView({super.key,required this.merchantId,required this.merchantName});
  final String merchantId;
  final String merchantName;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: TakeOperationViewBody(merchantId: merchantId, merchantName: merchantName,),
        ),
      ),
    );
  }
}
