import 'package:email_validator/email_validator.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haf_calc/cubits/auth/register/register_cubit.dart';
import 'package:haf_calc/views/auth/login_view.dart';
import 'package:haf_calc/views/auth/widgets/terms_conditions.dart';
import '../../../utils/constants.dart';
import '../../customer_operations_view/widgets/default_text_form_field.dart';
import '../verify_view.dart';
import 'custom_auth_app_bar.dart';
import 'default_button.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});

  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
       if(state is RegisterSuccessState)
         {
           final snackBar = SnackBar(
             padding:  EdgeInsets.all(width*.03),
             content: const Text('تم ارسال رسالة التحقق'),
             action: SnackBarAction(
               label: 'أذهب',
               onPressed: () async {
                 await LaunchApp.openApp(
                   androidPackageName: 'com.google.android.gm',
                   openStore: true,
                 );
               },
             ),
           );

           // Find the ScaffoldMessenger in the widget tree
           // and use it to show a SnackBar.
           userId=FirebaseAuth.instance.currentUser!.uid;

           ScaffoldMessenger.of(context).showSnackBar(snackBar);
           Navigator.pushReplacement(context,
               MaterialPageRoute(builder: (context) => const VerifyPage()));
         }if (state is RegisterFailureState) {
         if (state.errMessage == "email-already-in-use") {
           var snackBar = const SnackBar(
             content: Text(
               'البريد الالكتروني موجود بالفعل',
               style: TextStyle(color: Colors.white),
             ),
             backgroundColor: Colors.red,
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         } else if (state.errMessage == "weak-password") {
           var snackBar = const SnackBar(
             content: Text(
               'الرقم السري ضعيف',
               style: TextStyle(color: Colors.white),
             ),
             backgroundColor: Colors.red,
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         }else{}
       }

      },
      builder: (context, state) {
        RegisterCubit cubit=RegisterCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: state is! RegisterLoadingState? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKeyLogin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAuthAppBar(),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                        textInputType: TextInputType.text,
                        controller: email,
                        maxLines: 1,

                        hintText: "البريد الالكتروني",
                        borderRadius: 30,
                        hasBorder: true,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال البريد الالكتروني";
                          } else if (EmailValidator.validate(value)) {
                            return null;
                          } else {
                            return "البريد الالكتروني غير صحيح";
                          }
                        },
                        prefixIcon: const Icon(CupertinoIcons.mail),
                        borderSideWidth: 1,
                        contentPaddingVertical: 11,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        textInputType: TextInputType.text,
                        controller: password,
                        isPassword: true,
                        maxLines: 1,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال كلمة المرور";
                          }
                        },
                        hintText: "كلمة المرور",
                        borderRadius: 30,
                        hasBorder: true,
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        borderSideWidth: 1,
                        contentPaddingVertical: 11,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                        textInputType: TextInputType.text,
                        controller: rePassword,
                        isPassword: true,
                        maxLines: 1,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال كلمة المرور";
                          } else if (value.length < 8) {
                            return "يجب الا تقل كلمة المرور عن 8 احرف ";
                          } else if (password.text != rePassword.text) {
                            return "كلمتا المرور غير متطابقتين";
                          }
                        },
                        hintText: "تأكيد كلمة المرور",
                        borderRadius: 30,
                        hasBorder: true,
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        borderSideWidth: 1,
                        contentPaddingVertical: 11,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultButton(
                        backgroundColor: const Color(0xff2b3396),
                        onPress: () {
                          if (formKeyLogin.currentState!.validate()) {
                            cubit.signUp(email.text, password.text);
                          }
                        },
                        text: 'انشاء حساب',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "هل لديك حساب ؟",
                            // style: Styles.onboardingdescriptiontext(),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              // GoRouter.of(context).push("/loginView");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LoginView()));
                            },
                            child: const Text("تسجيل الدخول",
                              // style: Styles.onboardingdescriptiontext().copyWith(
                              //     color: AppColors.secondaryColor,
                              //     fontWeight: FontWeight.w700
                              // ),
                              style: TextStyle(
                                color: Color(0xff2b3396),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const TermsConditions(),
                    ],
                  ),
                ),
              ],
            ),
          ):const Center(child: CircularProgressIndicator(color: Color(0xff2b3396),),)
        );
      },
    );
  }
}

