import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var credential;
  User? user;
  Future<void> signUp (String email,String password)
  async {
    emit(RegisterLoadingState());
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user!.emailVerified == false) {
        user = FirebaseAuth.instance.currentUser!;
        await user?.sendEmailVerification();
      }
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailureState(e.code));
      if (e.code == 'email-already-in-use') {
        print('The Account Already Exist for That Email .');
      } else if (e.code == 'weak-password') {
        print('The Password Provided is Too Weak.');
      }
    } catch(e)
    {
      emit(RegisterFailureState(e.toString()));
      print(e);
    }
  }
}
