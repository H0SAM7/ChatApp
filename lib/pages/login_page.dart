import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/test_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:chat_app/widget/custom_progress_hub.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  LoginPage({super.key});

  String? email;
  String? password;
  bool isloading = false;
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
              BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id,  arguments: {'email':state.email });
          isloading=false;
        } else if (state is LoginFuailer) {
          ShowSnackbar(context, state.errmessage);
            isloading=false;
        }
      },
      builder:(context,state)=> CustomProgressHUD(
        // progressIndicator: CustomLoadingIndicator(),
        inAsyncCall: isloading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: FromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: x * 0.3),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      icon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      label: 'Email',
                      hint: 'Enter your email',
                      onchage: (data) {
                        email = data;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      icon: Icon(Icons.lock, color: Colors.grey),
                      hide: true,
                      passicon: true,
                      label: 'Password',
                      hint: 'Enter your password',
                      onchage: (data) {
                        password = data;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                    child: CustomButton(
                        buttonName: 'LOGIN',
                        txtcolor: Colors.white,
                        color: Colors.lightBlueAccent,
                        onTap: () async {
                          if (FromKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .loginUser(email: email!, password: password!);
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: TextStyle(color: Colors.black)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text('REGISTER',
                              style: TextStyle(color: Colors.lightBlueAccent)))
                    ],
                  ),
                  SizedBox(height: x * 0.15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// on FirebaseAuthException catch (e) {
//                             if (e.code == 'user-not-found') {
//                               ShowSnackbar(
//                                   context, 'No user found for that email.');
//                             } else if (e.code == 'wrong-password') {
//                               ShowSnackbar(context,
//                                   'Wrong password provided for that user.');
//                             } else {
//                               ShowSnackbar(context, e.code.toString());
//                             }
//                           } catch (e) {
//                             print(e);
//                             ShowSnackbar(context, 'Something went wrong');
//                           }