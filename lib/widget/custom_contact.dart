import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';

class CustomContact extends StatelessWidget {
   CustomContact({super.key, this.email,this.sender});
  static String id = 'CustomContact';
  // final String? username;
  VoidCallback? onTap;
  String? email;
  String? sender;
  @override
  Widget build(BuildContext context) {
    return 

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: GestureDetector
          (onTap: (){
            
             Navigator.pushNamed(context,  ChatPage.id,arguments: {'username':email,

             'sender':sender
             },);
             
          },
            child: Container(
              height: 50,
              width: 400,
              //color: Colors.white,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/contact .png'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
                ),
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 60,top: 8),
                child: Text(
                              '${email}',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white,
                              fontSize: 20
                              ),
                            ),
              ),
            
            
                  
                ),
          ),
        );
  }
}
