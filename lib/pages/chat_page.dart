
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/widget/bubble_chat.dart';

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
  final TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  var emailsender = ModalRoute.of(context)!.settings.arguments;
    //  var userName = ModalRoute.of(context)!.settings.arguments;

    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var userName = args['username'];
    var emailsender = args['sender'] ?? 'no email';

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              
              
              messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
              
            }
       
            // for (int i = 0; i < snapshot.data!.docs.length; i++) {
            //   var x = snapshot.data!.docs[i];
            //   if (x.id == userName || x.id==email) {
            //     messagesList.add(Message.fromjson(x));
            //   }

            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
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
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, ind) {
                          return 
                          messagesList[ind].sender == emailsender
                              ? BubbleChat(message: messagesList[ind])
                              : BubbleChatFriend(message: messagesList[ind]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: TextField(
                          controller: controller,
                          onSubmitted: (data) {
                            messages.add({
                              'message': data,
                              'createdAt': DateTime.now(),
                              'time': getFormattedTime(),
                              'sender': emailsender,
                              'reciver': userName
                            });
                            controller.clear();
                            _controller.animateTo(0,
                                duration: Duration(seconds: 1),
                                curve: Easing.legacy);
                          },
                          decoration: InputDecoration(
                            hintText: 'Send Massage',
                            suffixIcon: Icon(Icons.send),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          )),
                    ),
                  ],
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

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

  void main() {
    final formattedTime = getFormattedTime();
    print("'time':'$formattedTime',");
  }
}
