import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/views/marchant_operations_view/marchant_operations_view.dart';

import '../../cubits/marchant/marchant_cubit.dart';
import '../customer_operations_view/widgets/default_text_form_field.dart';
import '../home_view/home_vew.dart';


class AddMarchant extends StatelessWidget {
  AddMarchant({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<MerchantCubit, MerchantState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is addMerchantSuccessState)
    {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MarchantOperationsView(merchantId: state.UserId!, merchantName: name.text)));
    }
  },
  builder: (context, state) {
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
                          "اضافة مورد جديد",
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
                          "اسم المورد",
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
                          "رقم المورد",
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
                        BlocBuilder<MerchantCubit, MerchantState>(
                          builder: (context, state) {
                            MerchantCubit cubit=MerchantCubit.get(context);
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    MaterialButton(
                                      elevation: 0,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.addMerchant(name.text, phone.text);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
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
                              ),
                            );
                          },
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
    );
  }
}
