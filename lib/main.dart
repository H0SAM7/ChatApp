import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/get_started_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/test_page.dart';
import 'package:chat_app/widget/custom_contact.dart';
import 'package:chat_app/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
          
        ),
        BlocProvider(create: (context)=>ChatCubit())
      ],
      child: MaterialApp(
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: _themeMode,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ChatPage.id: (context) => ChatPage(),
            CustomContact.id: (context) => CustomContact(),
            ListOfUsers.id: (context) => ListOfUsers(),
            SearchAppBarDemo.id: (context) => SearchAppBarDemo(),
            // MessagesScreen.id:(context) => MessagesScreen(),
            GetStartedPage.id: (context) => const GetStartedPage(),
            TestPage.id:(context) => const TestPage(),
          },
          debugShowCheckedModeBanner: false,
          initialRoute: GetStartedPage.id),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}































// import 'package:chat_app/helper/grouped_messages.dart';
// import 'package:chat_app/pages/chat_page.dart';
// import 'package:chat_app/pages/home_page.dart';
// import 'package:chat_app/pages/list_of_users_page.dart';
// import 'package:chat_app/pages/ll.dart';
// import 'package:chat_app/pages/register_page.dart';
// import 'package:chat_app/widget/custom_contact.dart';
// import 'package:chat_app/widget/search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async{
//    WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
// theme: ThemeData(),
//       darkTheme: ThemeData.dark(), // standard dark theme
//     // device controls theme
//       routes: {
//         'HomePage':(context) => HomePage(),
//         RegisterPage.id:(context) => RegisterPage(),
//         ChatPage.id:(context) => ChatPage(),
//        CustomContact.id:(context) => CustomContact(),
//         ListOfUsers.id:(context) => ListOfUsers(),
//         SearchAppBarDemo.id:(context) => SearchAppBarDemo(),
//         // MessagesScreen.id:(context) => MessagesScreen(),
//         login.id:(context) => login(),
//       },
   
//       debugShowCheckedModeBanner: false,
//       initialRoute:   'HomePage'
//     );
//   }
// }












