import 'package:flutter/material.dart';

import 'deal_out_list_item.dart';

class DaelOutList extends StatelessWidget {
  const DaelOutList({super.key,required this.transactions});
  final List<dynamic> transactions;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isNotEmpty ? ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return  DealOutListItem(transaction:transactions[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ):const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open),
          Text(
            "ابدأ معاملاتك الامنة مع احسبها"
          )
        ],),
      ),
    );
  }
}