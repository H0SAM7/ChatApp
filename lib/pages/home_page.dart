import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  String? password;
  bool isloading = false;
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: FromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: x * 0.11),
                Image.asset('assets/images/scholar.png'),
                Text(
                  'Scolar Chat',
                  style: TextStyle(
                      fontFamily: 'Pacifico', fontSize: 35, color: Colors.white),
                ),
                SizedBox(height: x * 0.11),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
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
                    hide: true,
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
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text('REGISTER',
                            style: TextStyle(color: Color(0xffC7EDE6))))
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
