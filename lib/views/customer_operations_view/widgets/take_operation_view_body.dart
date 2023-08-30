import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../cubits/transactions/transactions_cubit.dart';
import 'default_text_form_field.dart';
import '../../customer_operations_view/customer_operations_view.dart';
import '../../customer_operations_view/widgets/custom_app_bar_takes_operation.dart';

class TakeOperationViewBody extends StatelessWidget {
  TakeOperationViewBody({super.key,required this.customerId,required this.customerName});
final String customerId;
final String customerName;
  var amount = TextEditingController();
  var details = TextEditingController();
  var datePicked = TextEditingController(text: DateFormat('yyyy-MM-dd hh:mm:ss a').format(DateTime.now()));
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBarTakesOperation(customerName: customerName,),
        const SizedBox(height: 20,),
        Form(
          key: formKey,
          child: Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DefaultTextFormField(
                    contentPaddingVertical: 20,
                    textInputType: TextInputType.number,
                    controller: amount,
                    hintText: "0.00ج.م",
                    numberOfChars: 9,
                    validation: (String? value) {
                      if (value!.isEmpty) {
                        return "يجب ادخال قيمة المعاملة";
                      }
                    },
                    style: const TextStyle(fontFamily: "Cairo"),

                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DefaultTextFormField(
                    contentPaddingVertical: 20,
                    textInputType: TextInputType.text,
                    controller: details,
                    hintText: "تفاصيل المعاملة",
                    style: const TextStyle(fontFamily: "Cairo"),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("تاريخ المعاملة",style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                const SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DefaultTextFormField(
                      onTap: () async {
                        DateTime? date = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());
                        date = await showDatePicker(
                            context: context,
                            builder: (context,child){
                              return Theme(data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color(0xff2b3396), // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Color(0xfffa417a), // button text color
                                  ),
                                ),
                              ), child: child!,);
                            },
                            initialDate:DateTime.now(),
                            firstDate:DateTime(1900),
                            lastDate: DateTime(2100));

                        datePicked.text = formatter.format(date!);
                      },
                      textInputType: TextInputType.text,
                      controller: datePicked,
                      contentPaddingVertical: 20,
                      prefixIcon: const Icon(Icons.calendar_month_outlined),
                      hintText: formatter.format(now),
                    )),
                const SizedBox(height: 10,),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Text("أضف فاتورة",style: TextStyle(
                //       fontFamily: "Cairo",
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold
                //   ),),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //   child: IconButton(onPressed: (){}, icon: Image.asset("assets/images/add-photo.png",color: const Color(0xff2b3396),)),
                // ),
                BlocBuilder<TransactionsCubit, TransactionsState>(
                  builder: (context, state) {
                    TransactionsCubit cubit=TransactionsCubit.get(context);
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                  {
                                    cubit.addTransaction(-double.parse(amount.text), details.text,datePicked.text,customerId, "");
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerOperationsView(userName:customerName,userId: customerId)));
                                  }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: const Color(0xffe0e0e0),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "حفظ",
                                  style: TextStyle(color: Colors.white,fontFamily: "Cairo",fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
