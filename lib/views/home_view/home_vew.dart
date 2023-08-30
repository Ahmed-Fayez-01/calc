import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/cubits/customer/customer_cubit.dart';
import 'package:haf_calc/views/customer_operations_view/add_customer.dart';
import 'package:haf_calc/views/customer_operations_view/customer_operations_view.dart';
import 'package:haf_calc/views/marchant_operations_view/add_marchant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../cubits/marchant/marchant_cubit.dart';
import '../../utils/components.dart';
import '../../utils/constants.dart';
import '../marchant_operations_view/marchant_operations_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomerCubit.get(context).getAllCustomers();
    MerchantCubit.get(context).getAllMerchants();
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          showExitPopup(
              title: 'الخروج من البرنامج',
              context: context,
              content: "هل أنت متأكد من الخروج ؟",
              buttonText1: 'نعم',
              buttonText2: 'لا',
              onPress: () {
                exit(0);
              });
          return true;
        },
        child: Scaffold(
          floatingActionButton: !isExporter
              ? FittedBox(
                  child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFF2B3396),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddCustomer()));
                    },
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: [
                        Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        Text(
                          'إضافة عميل',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              : FittedBox(
                  child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFF2B3396),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddMarchant()));
                    },
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: [
                        Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        Text(
                          'إضافة مورد',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
          body: Column(children: [
            Container(
              decoration: const BoxDecoration(color: Color(0xFF2B3396)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (isExporter == false) {
                              setState(() {
                                isExporter = true;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: isExporter
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                'مورد',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isExporter
                                      ? const Color(0xFF2B3396)
                                      : Colors.white.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (isExporter == true) {
                              setState(() {
                                isExporter = false;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: isExporter
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Text(
                                'عميل',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isExporter
                                      ? Colors.white.withOpacity(0.4)
                                      : const Color(0xFF2B3396),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !isExporter
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: BlocBuilder<CustomerCubit, CustomerState>(
                                builder: (context, state) {
                                  CustomerCubit cubit =
                                      CustomerCubit.get(context);
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${(cubit.forMe).toInt()} ج.م",
                                              style: const TextStyle(
                                                color: Color(0xfffa417a),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              'ليا بره',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                        color: Colors.black54,
                                        height: 50,
                                        width: 0.5,
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          children: [
                                            Text(
                                              cubit.forYou != 0
                                                  ? '${(cubit.forYou * -1).toInt()} ج.م'
                                                  : '${(cubit.forYou).toInt()} ج.م',
                                              style: const TextStyle(
                                                color: Color(0xFF2B3396),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              'عليا',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: BlocBuilder<MerchantCubit, MerchantState>(
                                builder: (context, state) {
                                  MerchantCubit cubit =
                                      MerchantCubit.get(context);
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${(cubit.forMe).toInt()}ج.م ",
                                              style: const TextStyle(
                                                color: Color(0xfffa417a),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              'عليا',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                        color: Colors.black54,
                                        height: 50,
                                        width: 0.5,
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          children: [
                                            Text(
                                              cubit.forYou != 0
                                                  ? '${(cubit.forYou * -1).toInt()} ج.م'
                                                  : '${(cubit.forYou).toInt()} ج.م',
                                              style: const TextStyle(
                                                color: Color(0xFF2B3396),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              'مدفوع مقدم',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            !isExporter
                ? BlocBuilder<CustomerCubit, CustomerState>(
                    builder: (context, state) {
                      CustomerCubit cubit = CustomerCubit.get(context);

                      return Expanded(
                        child: state is! getAllCustomersLoadingState
                            ? cubit.customers.isNotEmpty ? ListView.separated(
                                itemCount: cubit.customers.length,
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Divider(),
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerOperationsView(
                                                    userId: cubit.customers[index]
                                                        ['id'],
                                                    userName:
                                                        cubit.customers[index]
                                                            ["data"]['name'],
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12),
                                      child: Row(
                                        children: [
                                          cubit.customers[index]["data"]
                                                      ['balance'] <
                                                  0
                                              ? Text(
                                                  "${cubit.customers[index]["data"]['balance'] * -1}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF2B3396)),
                                                )
                                              : Text(
                                                  "${cubit.customers[index]["data"]['balance']}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xfffa417a)),
                                                ),
                                          const Spacer(),
                                          Text(
                                            cubit.customers[index]["data"]
                                                ['name'],
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Color(0xFF2B3396),
                                            child: Text(
                                              cubit.customers[index]["data"]
                                                  ['name'][0],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ):const Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.group_add_outlined),
                            SizedBox(width: 10,),
                            Text(
                                "ابدأ اضافة العملاء الخاصة بك"
                            )
                          ],),)
                            : const Center(child: CircularProgressIndicator()),
                      );
                    },
                  )
                : BlocBuilder<MerchantCubit, MerchantState>(
                    builder: (context, state) {
                      MerchantCubit cubit = MerchantCubit.get(context);
                      return Expanded(
                        child: BlocBuilder<MerchantCubit, MerchantState>(
                          builder: (context, state) {
                            MerchantCubit cubit = MerchantCubit.get(context);
                            return state is! getAllMerchantsLoadingState
                                ? cubit.merchants.isNotEmpty? ListView.separated(
                                    itemCount: cubit.merchants.length,
                                    separatorBuilder: (context, index) =>
                                        const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Divider(),
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MarchantOperationsView(
                                                        merchantId:
                                                            cubit.merchants[index]
                                                                ['id'],
                                                        merchantName:
                                                            cubit.merchants[index]
                                                                ["data"]['name'],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 12),
                                          child: Row(
                                            children: [
                                              cubit.merchants[index]["data"]
                                                          ['balance'] <
                                                      0
                                                  ? Text(
                                                      "${cubit.merchants[index]["data"]['balance'] * -1}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFF2B3396)),
                                                    )
                                                  : cubit.merchants[index]["data"]
                                                              ['balance'] !=
                                                          0
                                                      ? Text(
                                                          "${cubit.merchants[index]["data"]['balance']}",
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xfffa417a)),
                                                        )
                                                      : Text(
                                                          "${cubit.merchants[index]["data"]['balance']}",
                                                          style: const TextStyle(
                                                              fontSize: 18),
                                                        ),
                                              const Spacer(),
                                              Text(
                                                cubit.merchants[index]["data"]
                                                    ['name'],
                                                style:
                                                    const TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              CircleAvatar(
                                                backgroundColor:
                                                    const Color(0xFF2B3396),
                                                child: Text(
                                                  cubit.merchants[index]["data"]
                                                      ['name'][0],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ):const Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.group_add_outlined),
                                SizedBox(width: 10,),
                                Text(
                                    "ابدأ اضافة الموردين الخاصة بك"
                                )
                              ],),)
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ),
                      );
                    },
                  ),
          ]),
        ),
      ),
    );
  }
}

class AgentsReport extends StatefulWidget {
  const AgentsReport({super.key});

  @override
  State<AgentsReport> createState() => _AgentsReportState();
}

class _AgentsReportState extends State<AgentsReport> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        // barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'اختر الفترة الزمنية',
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: const Text('تم'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    void _showBottomSheet(BuildContext context) {
      int selectedRadio = 0;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Text(
                    'بحث بواسطة',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile(
                      title: const Text('الكل'),
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          selectedRadio = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('الأسبوع الماضي'),
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          selectedRadio = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('هذا الشهر'),
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          selectedRadio = value!;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF2B3396),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'نتيجة البحث',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('تقرير العملاء')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _showMyDialog();
                  },
                  child: const Icon(
                    Icons.date_range_rounded,
                    size: 34,
                  ),
                ),
                const Text(
                  'مدة التقرير',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: const Icon(
                    Icons.filter_list_rounded,
                    size: 34,
                  ),
                ),
                const Text(
                  'تصفية',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '800 L.E',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'صافي الحساب',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
//reports and search
// !isExporter
//     ? Directionality(
//         textDirection: TextDirection.rtl,
//         child: TextFormField(
//           textAlign: TextAlign.right,
//           textDirection: TextDirection.rtl,
//           controller: searchController,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(
//               Icons.search_rounded,
//               size: 32,
//               color: Colors.grey,
//             ),
//             hintText: 'ابحث عن اسم',
//             hintStyle: const TextStyle(fontSize: 18),
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const AgentsReport()));
//                   },
//                   icon: const Icon(
//                     Icons.picture_as_pdf_outlined,
//                     color: Color(0xFF2B3396),
//                     size: 38,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.filter_list_rounded,
//                     color: Color(0xFF2B3396),
//                     size: 38,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           onChanged: (value) {
//             print(value);
//           },
//           onSaved: (String? value) {},
//           style: const TextStyle(color: Colors.black),
//         ),
//       )
//     : Directionality(
//         textDirection: TextDirection.rtl,
//         child: TextFormField(
//           textAlign: TextAlign.right,
//           textDirection: TextDirection.rtl,
//           controller: searchController,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(
//               Icons.search_rounded,
//               size: 32,
//               color: Colors.grey,
//             ),
//             hintText: 'ابحث عن اسم',
//             hintStyle: const TextStyle(fontSize: 18),
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     // final data = await service.createHelloWorld();
//                     // service.savePdfFile("invoice_$number", data);
//                     // number++;
//                   },
//                   icon: const Icon(
//                     Icons.picture_as_pdf_outlined,
//                     color: Color(0xFF2B3396),
//                     size: 38,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.filter_list_rounded,
//                     color: Color(0xFF2B3396),
//                     size: 38,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           onChanged: (value) {
//             print(value);
//           },
//           onSaved: (String? value) {},
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
