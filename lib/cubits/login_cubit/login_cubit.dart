
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginLoading());
  String? emailU;
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      emailU=email;
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess(email: email));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       emit(LoginFuailer(errmessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
       emit(LoginFuailer(errmessage: 'Wrong password provided for that user.'));
      } else {
      emit(LoginFuailer(errmessage: e.code.toString()));
      }
    } catch (e) {
      log(e.toString());
    emit(LoginFuailer(errmessage: 'Something went wrong'));
    }
  }
}
