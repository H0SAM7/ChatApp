import 'package:chat_app/constants.dart';
import 'package:chat_app/widget/custom_contact.dart';
import 'package:chat_app/widget/home_bar_menu.dart';
import 'package:chat_app/widget/menu_side.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ListOfUsers extends StatelessWidget {
   ListOfUsers({super.key});
  static String id='ListOfUsers';
  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchUserEmailsStream() {
    return firestore.collection('users').snapshots();
  }
  @override
  Widget build(BuildContext context) {
  final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

 var emaillogin = args['email'];
        return StreamBuilder<QuerySnapshot>(
         stream:  fetchUserEmailsStream(),
         builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No user emails found'));
          } else {
            return Scaffold(
             drawer: menuSide(),
              appBar: AppBar(automaticallyImplyLeading: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 40,
                      ),

                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
                      ),
                   
                    ],
                  ),
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,)
                  ,
              body: Column(
                children: [
                  HomeBar(),
                  Expanded(
                    child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var userDoc = snapshot.data!.docs[index];
                      return CustomContact(email: userDoc['email'],sender: emaillogin,);
                              
                    },
                                ),
                  ),
              ],
             
              ),
            );
          }
        },
      );
  }
  
}

// class MyAccount extends StatelessWidget {
//    MyAccount({super.key});

// static String id='MyAccount';
//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: CustomButton(buttonName: 'Your E-mail: ${Widget.emaillogin}'),
//     );
//   }
// }