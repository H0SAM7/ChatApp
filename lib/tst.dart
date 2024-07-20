// import 'dart:developer';
// import 'package:chat_app/constants.dart';
// import 'package:chat_app/model/chat_model.dart';
// import 'package:chat_app/model/message_model.dart';
// import 'package:chat_app/widget/bubble_chat.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

// class ChatPage extends StatelessWidget {
//   ChatPage({super.key});
//   static String id = 'ChatPage';
//   CollectionReference messages =
//       FirebaseFirestore.instance.collection(Kmessages);
//   TextEditingController controller = TextEditingController();
//   Stream collectionStream =
//       FirebaseFirestore.instance.collection(Kmessages).snapshots();
//   final ScrollController _controller = ScrollController();
//   final TextEditingController textcontroller = TextEditingController();
//   static String? time;
//   static String? mass;
//   static String? date;
//   List<Message>? massList;
//   String? groupId;
//   static List<Message> firstMessagesList = [];
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     var reciver = args['username'];
//     var emailsender = args['sender'] ?? 'no email';

//     return StreamBuilder<QuerySnapshot>(
//       stream: messages
//           .orderBy(
//             'createdAt',
//             descending: true,
//           )
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Message> messagesList = [];
//           massList = messagesList;

//           // Check if groupId already exists, if not create a new one
//           groupId = Uuid().v4(); // Generate a new unique UUID for the group
//           firstMessagesList = getFirstMessages(snapshot.data!.docs);
//           log('${firstMessagesList.length}@@@@@@@@@@@@@@@');
//           for (var message in firstMessagesList) {
//           mass=  message.message.toString();
//           }
//           for (int i = 0; i < snapshot.data!.docs.length; i++) {
//             var message = Message.fromjson(snapshot.data!.docs[i]);

//             if (message.sender == emailsender && message.reciver == reciver) {
//               messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
//               // Set the same groupId for messages in the same conversation
//               groupId = message
//                   .groupId; // Assuming 'groupId' is part of the message document
//             }
//           }

//           // ChatProcessor().processAndGetFirstMessages(massList!);
//           // mass = ChatProcessor().processAndGetFirstMessages(messagesList)[0][0];
//           // date = ChatProcessor().processAndGetFirstMessages(massList!)[0][1];
//           // log('${ChatProcessor().processAndGetFirstMessages(massList!)}');
//           // log('${date}@@@@@@@@@@@@@@@');

//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/scholar.png',
//                     height: 40,
//                   ),
//                   Text(
//                     'Chat',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//               backgroundColor: kPrimaryColor,
//               centerTitle: true,
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     controller: _controller,
//                     itemCount: messagesList.length,
//                     itemBuilder: (context, ind) {
//                       return messagesList[ind].sender == emailsender
//                           ? BubbleChat(message: messagesList[ind])
//                           : BubbleChatFriend(message: messagesList[ind]);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 1.0),
//                   child: TextField(
//                     controller: controller,
//                     onSubmitted: (data) {
//                       messages.add({
//                         'message': data,
//                         'createdAt': DateTime.now(),
//                         'time': getFormattedTime(),
//                         'sender': emailsender,
//                         'reciver': reciver,
//                         'groupId': groupId, // Include the groupId here
//                       });
//                       time = getFormattedTime();
//                       mass = data;
//                       controller.clear();
//                       _controller.animateTo(
//                         0,
//                         duration: Duration(seconds: 1),
//                         curve: Easing.legacy,
//                       );
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Send Message',
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: () {
//                           if (controller.text.isNotEmpty) {
//                             messages.add({
//                               'message': controller.text,
//                               'createdAt': DateTime.now(),
//                               'time': getFormattedTime(),
//                               'sender': emailsender,
//                               'reciver': reciver,
//                               'groupId': groupId, // Include the groupId here
//                             });
//                             controller.clear();
//                             _controller.animateTo(
//                               0,
//                               duration: Duration(microseconds: 500),
//                               curve: Curves.easeInOut,
//                             );
//                           }
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   // Function to get groupId
//   String getGroupId(String sender, String receiver) {
//     return '${sender}_to_${receiver}';
//   }

//   // Function to get the first message for each group
//   List<Message> getFirstMessages(List<DocumentSnapshot> docs) {
//     Map<String, Message> groupedMessages = {};

//     for (var doc in docs) {
//       var message = Message.fromjson(doc);
//       if (!groupedMessages.containsKey(message.groupId)) {
//         groupedMessages[message.groupId!] = message;
//       }
//     }

//     return groupedMessages.values.toList();
//   }

//   String getFormattedTime() {
//     final currentTime = DateTime.now();
//     int hour = currentTime.hour;
//     final isPM = hour >= 12;
//     if (hour > 12) {
//       hour -= 12;
//     } else if (hour == 0) {
//       hour = 12;
//     }
//     final hours = hour.toString().padLeft(2, '0');
//     final minutes = currentTime.minute.toString().padLeft(2, '0');
//     return '$hours:$minutes ${isPM ? 'PM' : 'AM'}';
//   }

//   void main() {
//     final formattedTime = getFormattedTime();
//     print("'time':'$formattedTime',");
//   }
// }
