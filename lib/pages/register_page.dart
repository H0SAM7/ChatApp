import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_progress_hub.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  String? username;
  bool isloading = false;

  GlobalKey<FormState> FromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.height;
    return CustomProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: FromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: x * 0.3),
                //     CircleAvatar(
                //   radius: 85, // Adjust the radius as needed
                //   backgroundImage: AssetImage('assets/images/chat.png'),
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Text('Log In: ',style: TextStyle(color: Colors.white,fontSize: 26),),
                    ],
                  ),
                ),
                // CustomTextField(
                //   hint: 'enter your name',
                //   label: 'Username',

                // ),
                CustomTextField(
                    label: 'Username',
                    hint: 'Enter your name',
                    icon: Icon(Icons.add_sharp, color: Colors.grey),
                    onchage: (data) {
                      username = data;
                    }),
                CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    onchage: (data) {
                      email = data;
                    }),
                CustomTextField(
                  hide: true,
                  label: 'Password',
                  hint: 'Enter your password',
                   passicon: true,
                  icon: Icon(Icons.lock, color: Colors.grey),
                  onchage: (data) {
                    password = data;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                  child: CustomButton(
                      color: Colors.lightBlueAccent,
                      onTap: () async {
                        isloading = true;
                        setState(() {});

                        if (FromKey.currentState!.validate()) {
                          try {
                            await RegisterUser();
                            Navigator.pushNamed(
                              context, ListOfUsers.id,
                              //  arguments: email
                              arguments: {
                                'email': email,
                                'username': username,
                              },
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ShowSnackbar(context,
                                  'The password is weak, please adding some chars (!@#%)');
                            } else if (e.code == 'email-already-in-use') {
                              ShowSnackbar(
                                  context, 'The email already registred');
                            } else {
                              ShowSnackbar(context, e.code.toString());
                            }
                          }
                        }
                        isloading = false;
                        setState(() {});
                      },
                      buttonName: 'REGISTER',
                      txtcolor: Colors.white,
                      ),
                      
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have account?',
                        style: TextStyle(color: Colors.black)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('LOGIN',
                            style: TextStyle(color:    Colors.lightBlueAccent,)))
                  ],
                ),
                SizedBox(height: x * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> RegisterUser() async {
  //  final auth =FirebaseAuth.instance;
  //   await
  //       auth.createUserWithEmailAndPassword(email: email!, password: password!);
  //     // log('${auth.} wwwwwwwwwwwwwwwwwwwwwwwwwww');
  // }

  Future<void> RegisterUser() async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      // Store user email in Firestore
      await firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'username': username,
      });
    } catch (e) {
      // Handle registration error
      print('@@@@@@@@@@@@@@@@@@@@@@@@Registration error: $e');
    }
  }

// AddingData(){
//   DatabaseReference ref = FirebaseDatabase.instance.ref("username");

// }
}
