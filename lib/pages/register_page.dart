
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/widget/custom_button.dart';
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
 static String? currenEmail ;
  String? password;

  bool isloading = false;

  GlobalKey<FormState> FromKey = GlobalKey();

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
                 SizedBox(height: x * 0.15),
                Image.asset('assets/images/scholar.png'),
                Text(
                  'Scolar Chat',
                  style: TextStyle(
                      fontFamily: 'Pacifico', fontSize: 35, color: Colors.white),
                ),
                SizedBox(height: x * 0.15),
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
                    label: 'Email',
                    hint: 'Enter your email',
                    onchage: (data) {
                      email = data;
                      
                    }),
                CustomTextField(
                  hide: true,
                  label: 'Password',
                  hint: 'Enter your password',
                  onchage: (data) {
                    password = data;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
                  child: CustomButton(
                      onTap: () async {
                        isloading = true;
                        setState(() {});
          
                        if (FromKey.currentState!.validate()) {
                          try {
                            await RegisterUser();
                            Navigator.pushNamed(context, ListOfUsers.id,
                              //  arguments: email
                             arguments: {'email': email,
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
                      buttonName: 'REGISTER'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have account?',
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('LOGIN',
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
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email!, password: password!);

    // Store user email in Firestore
    await firestore.collection('users').doc(userCredential.user?.uid).set({
      'email': email,
    });

  } catch (e) {
    // Handle registration error
    print('Registration error: $e');
  }
}

}
