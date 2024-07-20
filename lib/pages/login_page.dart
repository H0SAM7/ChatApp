import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:chat_app/widget/custom_progress_hub.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id='LoginPage';
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isloading = false;
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.height;

    return CustomProgressHUD(
      
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
                      icon: Icon(Icons.email,color: Colors.grey,),
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
               icon: Icon(Icons.lock,color: Colors.grey),
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
                      isloading = true;
                     
                      setState(() {});
                      if (FromKey.currentState!.validate()) {
                        try {
                          await LoginUser();
                          Navigator.pushNamed(
                            context,
                            ListOfUsers.id,
                            arguments: {'email': email},
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ShowSnackbar(context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            ShowSnackbar(context, 'Wrong password provided for that user.');
                          } else {
                            ShowSnackbar(context, e.code.toString());
                          }
                        } catch (e) {
                          print(e);
                          ShowSnackbar(context, 'Something went wrong');
                        }
                      }
                      isloading = false;
                      setState(() {});
                    },
                  ),
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
      
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}