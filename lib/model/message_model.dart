class Message{
  final String? message;
  final String? sender;
  final String? reciver;
Message(this.message,this.sender,this.reciver);


  factory Message.fromjson(josn){
    return Message(josn['message'],josn['sender'],josn['reciver']);

  }
}