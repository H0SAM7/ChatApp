import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';



class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
CollectionReference messages = FirebaseFirestore.instance.collection(Kmessages);
  void sendMEssage({required String message, required String email}) {
    try {
      messages.add({
        'message': message,
        'createdAt': DateTime.now(),
         'sender': email,
      });
   
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    List<Message> messagesList=[];
    messages
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots().listen((event) {
           for (var doc in event.docs) {
            messagesList.add(Message.fromjson(doc));
      
    }    
            emit(ChatSuccess(messageList:messagesList));
        });

   
  }


}
