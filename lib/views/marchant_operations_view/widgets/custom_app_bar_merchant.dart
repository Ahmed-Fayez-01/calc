import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/cubits/transactions/transactions_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,required this.merchantName});
  final String merchantName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return  Container(
      height: height / 3.5,
      decoration: const BoxDecoration(
        color: Color(0xff2b3396),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      )),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: const Color(0xff2e55ba),
                    child: Text(
                      merchantName[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      merchantName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo"),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 28,
                      )),
                ],
              ),
            ),
            BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                TransactionsCubit cubit=TransactionsCubit.get(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 60),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cubit.balance<0?Text(
                          "${(cubit.balance*-1).toInt()} ج.م",
                          style: const TextStyle(
                              color: Color(0xff2b3396),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                        ): Text(
                          "${(cubit.balance).toInt()} ج.م",
                          style: const TextStyle(
                              color: Color(0xfffa417a),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                        ),
                        cubit.balance<0?const Text(
                          "مدفوع مقدم",
                          style: TextStyle(
                              color: Color(0xff363b65),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                        ):const Text(
                          "عليا",
                          style: TextStyle(
                              color: Color(0xff363b65),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
