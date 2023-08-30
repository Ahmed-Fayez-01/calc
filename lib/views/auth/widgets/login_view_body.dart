import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haf_calc/cubits/auth/login/login_cubit.dart';
import 'package:haf_calc/views/auth/register_view.dart';
import 'package:haf_calc/views/auth/widgets/terms_conditions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:haf_calc/views/home_view/home_vew.dart';
import '../../../utils/constants.dart';
import '../../customer_operations_view/widgets/default_text_form_field.dart';
import '../verify_view.dart';
import 'custom_auth_app_bar.dart';
import 'default_button.dart';


class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
          var snackBar = const SnackBar(
            content: Text(
              'Successful Login',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else if (state is LoginVerifyState) {
          pageNum = 1;
          userId = FirebaseAuth.instance.currentUser!.uid;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const VerifyPage()),
                  (route) => false);
        }else if (state is LoginFailureState) {
          if (state.errMessage == "user-not-found" ||
              state.errMessage == "wrong-password") {
            var snackBar = const SnackBar(
              content: Text(
                'خطأ في البريد الالكتروني او الرقم السري',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {}
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child:state is! LoginLoadingState? SingleChildScrollView(
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
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultButton(
                        backgroundColor: const Color(0xff2b3396),
                        onPress: () {
                          if (formKeyLogin.currentState!.validate()) {
                            if (hasInternet) {
                              if (formKeyLogin.currentState!
                                  .validate()) {
                                cubit.signIn(email.text, password.text);
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "No Internet Connection",
                                toastLength:
                                Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor:
                                Colors.transparent,
                                textColor:
                                const Color(0xff1bbd9d),
                              );
                            }

                          }
                        },
                        text: 'تسجيل الدخول',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "هل ليس لديك حساب ؟",
                            // style: Styles.onboardingdescriptiontext(),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RegisterView()));
                            },
                            child: const Text("انشاء حساب",
                              // style: Styles.onboardingdescriptiontext().copyWith(
                              //   color: AppColors.secondaryColor,
                              //   fontWeight: FontWeight.w700
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
          ):const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}
