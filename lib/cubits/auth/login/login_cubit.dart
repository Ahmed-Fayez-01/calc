import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../utils/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  var credential;
  Future<void> signIn (String email,String password)
  async {
    emit(LoginLoadingState());
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        if (value.user!.emailVerified) {
          userId = FirebaseAuth.instance.currentUser!.uid;
          emit(LoginSuccessState());
        } else {
          emit(LoginVerifyState());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(LoginFailureState(e.code));
    } catch(e)
    {
      emit(LoginFailureState(e.toString()));
      print(e);
    }
  }
}
