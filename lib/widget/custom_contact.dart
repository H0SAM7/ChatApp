// import 'package:chat_app/constants.dart';
// import 'package:chat_app/model/message_model.dart';
// import 'package:chat_app/pages/chat_page.dart';
// import 'package:flutter/material.dart';

// class CustomContact extends StatelessWidget {
//    CustomContact({super.key, this.email,this.sender,this.message});
//   static String id = 'CustomContact';
//   // final String? username;
//   VoidCallback? onTap;
//   String? email;
//   String? sender;
//   final Message? message;
//   @override
//   Widget build(BuildContext context) {
//     return

//         Column(

//           children: [
//       GestureDetector
//           (onTap: (){

//              Navigator.pushNamed(context,  ChatPage.id,arguments: {'username':email,

//              'sender':sender
//              },);

//           },
//             child: Container(
//               height: 50,
//               width: 400,
//               //color: Colors.white,
//               decoration: BoxDecoration(
//                 // image: DecorationImage(
//                 //   image: AssetImage('assets/images/contact .png'),
//                 //   fit: BoxFit.fitHeight,
//                 //   alignment: Alignment.centerRight,
//                 // ),
//                 // color: kPrimaryColor,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                      CircleAvatar(
//                   radius: 30,
//                   backgroundImage: AssetImage('assets/images/UI_v.png'),
//                 ),

//                   Padding(
//                     padding: const EdgeInsets.only(left: 20,),
//                     child: Column(children: [
//                       Text(
//                                   '${email}',
//                                   textAlign: TextAlign.right,
//                                   style: TextStyle(color: Colors.black,
//                                   fontSize: 20
//                                   ),
//                                 ),
//                         Text(
//                                   '',
//                                   textAlign: TextAlign.right,
//                                   style: TextStyle(color: Colors.black,
//                                   fontSize: 10
//                                   ),
//                                 ),
//                     ],)
//                   ),
//                 ],
//               ),

//                 ),
//           ),
//           Divider(
//             thickness: 3,
//           )
//         ]);

//   }
// }


import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';

class CustomContact extends StatelessWidget {
  CustomContact(
      {super.key,
      this.username,
      this.sender,
      this.message,
      this.lastMessage,
      this.time,
      this.reciever,
      this.darkmode = false});
  static String id = 'CustomContact';
  final String? reciever;
  VoidCallback? onTap;
  String? username;
  String? sender;
  final Message? message;
  String? lastMessage;
  String? time;
  bool darkmode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatPage.id,
          arguments: {'sender': sender, 'reciever': reciever,},
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/cat.png'),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${username}',
                            style: TextStyle(
                                fontSize: 20,
                                color: darkmode ? Colors.white : Colors.black),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            lastMessage ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: darkmode
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time ?? '',
              style: TextStyle(
                fontSize: 12,
                color: darkmode ? Colors.white : Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
