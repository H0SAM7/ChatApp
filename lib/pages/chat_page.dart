import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/widget/bubble_chat.dart';
import 'package:chat_app/widget/custom_indecator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';

  TextEditingController controller = TextEditingController();
  Stream collectionStream =
      FirebaseFirestore.instance.collection(Kmessages).snapshots();
  final ScrollController _controller = ScrollController();
  static String? time;
  static String? mass;
  static String? date;
  String? groupId;
  // ChatProcessor processor = ChatProcessor();
  static List<Message> firstMessagesList = [];
  List<Message> messagesList = [];
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var reciver = args['reciever'] as String?;
    var emailsender = args['sender'] as String? ?? 'no email';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messageList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, ind) {
                    var message = messagesList[ind];
                    return message.sender == emailsender
                        ? BubbleChat(message: message)
                        : BubbleChatFriend(message: message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                if (data.isNotEmpty) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMEssage(message: data, email: emailsender);
                 
                  controller.clear();
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Easing.legacy,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: "     Write message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                       BlocProvider.of<ChatCubit>(context)
                      .sendMEssage(message: controller.text, email: emailsender);
                  time = getFormattedTime();
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to get groupId

  String getFormattedTime() {
    final currentTime = DateTime.now();
    int hour = currentTime.hour;
    final isPM = hour >= 12;
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    final hours = hour.toString().padLeft(2, '0');
    final minutes = currentTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes ${isPM ? 'PM' : 'AM'}';
  }
}
