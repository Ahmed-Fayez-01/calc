import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/views/customer_operations_view/take_operation_view.dart';
import 'package:haf_calc/views/customer_operations_view/widgets/custom_app_bar_customer.dart';
import 'package:haf_calc/views/customer_operations_view/widgets/deal_out_bar_customer.dart';
import 'package:haf_calc/views/customer_operations_view/widgets/deal_out_list_view.dart';
import '../../../cubits/transactions/transactions_cubit.dart';
import '../give_operation_view.dart';

class CustomerViewBody extends StatelessWidget {
  const CustomerViewBody(
      {super.key, required this.userId, required this.userName});

  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    TransactionsCubit.get(context).getAllCustomerTransaction(userId);
    return BlocBuilder<TransactionsCubit, TransactionsState>(
  builder: (context, state) {
    return state is! getAllTransactionLoadingState ? Column(
      children: [
        CustomAppBar(
          userName: userName,
        ),
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
                            builder: (context) => GiveOperationView(
                              customerId: userId,
                              customerName: userName,
                            )));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xfffa417a),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "اعطيت",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TakeOperationView(
                                  customerId: userId,
                                  customerName: userName
                                )));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xff2b3396),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "حصلت",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Cairo",
                          fontSize: 20),
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
