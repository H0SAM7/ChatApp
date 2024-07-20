



class Message{
  final String? message;
  final String? sender;
  final String? reciver;
  final String? time;
  final String? groupId;

Message(this.message,this.sender,this.reciver,this.time,this.groupId);



  factory Message.fromjson(josn){
    return Message(josn['message'],josn['sender'],josn['reciver'],josn['time'],josn['groupId']);

  }
}