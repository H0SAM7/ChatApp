
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/pages/list_of_users_page.dart';
import 'package:chat_app/widget/bubble_chat.dart';
import 'package:chat_app/widget/custom_indecator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Kmessages);
  TextEditingController controller = TextEditingController();
  Stream collectionStream =
      FirebaseFirestore.instance.collection(Kmessages).snapshots();
  final ScrollController _controller = ScrollController();
  static String? time;
  static String? mass;
  static String? date;
  List<Message>? massList;
  String? groupId;
  ChatProcessor processor = ChatProcessor();
  static List<Message> firstMessagesList = [];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var reciver = args['reciever'] as String?;
    var emailsender = args['sender'] as String? ?? 'no email';


    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CustomLoadingIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
          List<Message> messagesList = [];

          for (var doc in snapshot.data!.docs) {
            var message = Message.fromjson(doc);

            // Add messages that are either sent by the user or received from the user
            if ((message.sender == emailsender && message.reciver == reciver) ||
                (message.sender == reciver && message.reciver == emailsender)) {
              messagesList.add(message);
              groupId = '${message.sender}--to--${message.reciver}'; // Assuming 'groupId' is part of the message document
            }
          }
firstMessagesList=messagesList;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Center(child: Text('No message ')))
                      : ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, ind) {
                            var message = messagesList[ind];
                            return message.sender == emailsender
                                ? BubbleChat(message: message)
                                : BubbleChatFriend(message: message);
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      if (data.isNotEmpty) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'time': getFormattedTime(),
                          'sender': emailsender,
                          'reciver': reciver,
                          'groupId': groupId, // Include the groupId here
                        });
                        time = getFormattedTime();
                        mass = data;
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
                            messages.add({
                              'message': controller.text,
                              'createdAt': DateTime.now(),
                              'time': getFormattedTime(),
                              'sender': emailsender,
                              'reciver': reciver,
                              'groupId': groupId, // Include the groupId here
                            });
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
        } else {
          return Container();
        }
      },
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
