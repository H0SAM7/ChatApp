import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_contact.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'HomePage':(context) => HomePage(),
        RegisterPage.id:(context) => RegisterPage(),
        ChatPage.id:(context) => ChatPage(),
       CustomContact.id:(context) => CustomContact(),
        ListOfUsers.id:(context) => ListOfUsers(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'HomePage'
    );
  }
}












