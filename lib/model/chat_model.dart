// import 'package:chat_app/model/message_model.dart';

// class ChatProcessor {
//   Map<String, List<Message>> chatMap = {};

//   // This method processes the list of messages and returns the first message for each chat pair
//   List<List<String?>> processAndGetFirstMessages(List<Message> messages) {
//     // Populate the map with messages categorized by sender-receiver pairs
//     for (var message in messages) {
//       // Create a unique key for each sender-receiver pair
//       String key = message.sender! + "_" + message.reciver!;
//       String reverseKey = message.reciver! + "_" + message.sender!;

//       // If the key or reverse key already exists, add the message to the existing list
//       if (chatMap.containsKey(key)) {
//         chatMap[key]!.add(message);
//       } else if (chatMap.containsKey(reverseKey)) {
//         chatMap[reverseKey]!.add(message);
//       } else {
//         // Otherwise, create a new list for the key
//         chatMap[key] = [message];
//       }
//     }

//     // Collect the first message for each sender-receiver pair
//     List<List<String?>> firstMessages = [];
//     chatMap.forEach((key, value) {
//       var firstMessage = value.first;
//       firstMessages.add([
//         firstMessage.message, // Message
//         firstMessage.time     // Time
//       ]);
//     });

//     return firstMessages;
//   }

//   // This method returns the first message for a specific sender-receiver pair
//   Message? getFirstMessageForPair(String sender, String receiver) {
//     // Create the unique keys for the sender-receiver pair
//     String key = sender + "_" + receiver;
//     String reverseKey = receiver + "_" + sender;

//     // Check if the map contains the key or reverse key and return the first message if found
//     if (chatMap.containsKey(key)) {
//       return chatMap[key]!.first;
//     } else if (chatMap.containsKey(reverseKey)) {
//       return chatMap[reverseKey]!.first;
//     } else {
//       // Return null if no messages found for the pair
//       return null;
//     }
//   }
// }



















// // import 'package:chat_app/model/message_model.dart';
// // class ChatProcessor {
// //   Map<String, List<Message>> chatMap = {};

// //   List<List<String?>> processAndGetFirstMessages(List<Message> messages,String send,String recive) {
// //     // Populate the map
// //     for (var message in messages) {
// //       // Create a unique key for each sender-receiver pair
// //       String key = message.sender! + "_" + message.reciver!;
// //       String reverseKey = message.reciver! + "_" + message.sender!;

// //       // If the key or reverse key already exists, add the message to the existing list
// //       if (chatMap.containsKey(key)) {
// //         chatMap[key]!.add(message);
// //       } else if (chatMap.containsKey(reverseKey)) {
// //         chatMap[reverseKey]!.add(message);
// //       } else {
// //         // Otherwise, create a new list for the key
// //         chatMap[key] = [message];
// //       }
// //     }

// //     // Collect the first message for each sender-receiver pair
// //     List<List<String?>> firstMessages = [];
// //     chatMap.forEach((key, value) {
// //       var firstMessage = value.first;
// //       firstMessages.add([
// //         firstMessage.message, // Message
// //         firstMessage.time     // Time
// //       ]);
// //     });

// //     return firstMessages;
// //   }
// // }

// // Example usage (you can remove this part if you don't need it):
// /*
// void main() {
//   List<Message> messages = [
//     Message("Hello", "Alice", "Bob", "10:00"),
//     Message("Hi", "Bob", "Alice", "10:01"),
//     Message("How are you?", "Alice", "Bob", "10:02"),
//     Message("Good, thanks!", "Bob", "Alice", "10:03"),
//     Message("What's up?", "Alice", "Bob", "10:04"),
//   ];

//   ChatProcessor chatProcessor = ChatProcessor();
//   List<List<String?>> firstMessages = chatProcessor.processAndGetFirstMessages(messages);

//   for (var fm in firstMessages) {
//     print("Message: ${fm[0]}, Time: ${fm[1]}"); // Access message and time separately
//   }
// }
// */