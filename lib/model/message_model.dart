class Message {
  final String message;
  final String sender;
  final String time;

  Message({
    required this.message,
    required this.sender,
    required this.time,
  });

  factory Message.fromjson(josn) {
    return Message(
      message: josn['message'],
      sender: josn['sender'],
      time: josn['createdAt'].toString(),
    );
  }
}
