import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/views/customer_operations_view/customer_operations_view.dart';

import '../../cubits/customer/customer_cubit.dart';
import '../home_view/home_vew.dart';
import '../marchant_operations_view/widgets/default_text_form_field.dart';

class AddCustomer extends StatelessWidget {
  AddCustomer({super.key});

  var name = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          child: BlocConsumer<CustomerCubit, CustomerState>(
  listener: (context, state) {
    if(state is addCustomerSuccessState)
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerOperationsView(userId: state.UserId!, userName: name.text)));
      }
  },
  builder: (context, state) {
    CustomerCubit cubit =CustomerCubit.get(context);
    return Scaffold(
            body: Column(
              children: [
                Container(
                  height: 80,
                  decoration: const BoxDecoration(color: Color(0xff2b3396)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "اضافة عميل جديد",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "اسم العميل",
                            style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 18,
                                color: Color(0x4d000000),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultTextFormField(
                            contentPaddingVertical: 20,
                            textInputType: TextInputType.text,
                            controller: name,
                            hintText: "ادخل الاسم",
                            validation: (String? value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال اسم العميل";
                              }
                            },
                            style: const TextStyle(fontFamily: "Cairo"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "رقم العميل",
                            style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 18,
                                color: Color(0x4d000000),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultTextFormField(
                            contentPaddingVertical: 20,
                            textInputType: TextInputType.number,
                            controller: phone,
                            hintText: "ادخل الرقم",
                            style: const TextStyle(fontFamily: "Cairo"),
                          ),
                          Expanded(
                            child: state is! addCustomerLoadingState? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .stretch,
                                children: [
                                  MaterialButton(
                                    elevation: 0,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        await cubit.addCustomer(name.text, phone.text);

                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0),
                                    ),
                                    color: Colors.grey,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "تأكيد",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Cairo",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):const Center(child: CircularProgressIndicator(),)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  },
),
        ),
      ),
    );
  }
}
