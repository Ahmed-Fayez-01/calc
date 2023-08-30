import 'package:flutter/material.dart';
import 'package:haf_calc/views/customer_operations_view/widgets/take_operation_view_body.dart';

class TakeOperationView extends StatelessWidget {
  const TakeOperationView({super.key,required this.customerId,required this.customerName});
  final String customerId;
  final String customerName;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: TakeOperationViewBody(customerId: customerId, customerName: customerName,),
        ),
      ),
    );
  }
}
