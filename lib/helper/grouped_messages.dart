// import 'package:cloud_firestore/cloud_firestore.dart';

// class MessageService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<QuerySnapshot<Object?>>? getMessagesForSender(String senderEmail) {
//     return _firestore
//         .collection('messages')
//         .where('senderEmail', isEqualTo: senderEmail)
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
// }