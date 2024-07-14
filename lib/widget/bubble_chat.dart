import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
const BubbleChat({super.key,required this.message});
final Message message;
static String id='BubbleChat';
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16))),
                padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                child: Text(message.message!,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}


class BubbleChatFriend extends StatelessWidget {
const BubbleChatFriend({super.key,required this.message});
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(199, 74, 135, 182),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16))),
                padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16),
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                child: Text(message.message!,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
