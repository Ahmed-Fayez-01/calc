import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/views/marchant_operations_view/widgets/deal_out_bar.dart';
import 'package:haf_calc/views/marchant_operations_view/widgets/deal_out_list_view.dart';

import '../../../cubits/transactions/transactions_cubit.dart';
import '../buy_operation_view.dart';
import '../pay_operation_view.dart';
import 'custom_app_bar_merchant.dart';


class MarchantViewBody extends StatelessWidget {
  const MarchantViewBody({super.key ,required this.merchantId, required this.merchantName});
  final String merchantId;
  final String merchantName;

  @override
  Widget build(BuildContext context) {
    TransactionsCubit.get(context).getAllMerchantTransaction(merchantId);
    return BlocBuilder<TransactionsCubit, TransactionsState>(
  builder: (context, state) {
    return state is! getAllTransactionLoadingState ? Column(
      children: [
        CustomAppBar(merchantName: merchantName,),
        const SizedBox(
          height: 10,
        ),
        TransactionsCubit.get(context).transactions.isEmpty
            ? const SizedBox()
            : const DealOutBar(),
        const SizedBox(
          height: 10,
        ),
        DaelOutList(
          transactions: TransactionsCubit.get(context).transactions,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(

            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PayOperationView(
                              merchantId: merchantId,
                              merchantName: merchantName,
                            )));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xfffa417a),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "اشتريت",
                      style: TextStyle(color: Colors.white,fontFamily: "Cairo",fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyOperationView(
                                merchantId: merchantId,
                                merchantName: merchantName
                            )));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xff2b3396),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "دفعت",
                      style: TextStyle(color: Colors.white,fontFamily: "Cairo",fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ):const Center(child:CircularProgressIndicator());
  },
);
  }
}
