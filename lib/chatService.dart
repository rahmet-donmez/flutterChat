import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/message.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatService {
  FirebaseFirestore firestore= FirebaseFirestore.instance;
 


  sendMessagge(String messageText)async{
    Message message=Message(senderId: "MjkkcUlLGfOE3UsEE84ldCcZLSJ3", receiverId: "KgPVLyx1BHfsO6GshV30oV6LAwm1", messageText: messageText, dateTime: DateTime.now());
    List<String> ids=[message.senderId.toString(),message.receiverId.toString()];
    ids.sort();
    String room_id=ids.join("_");
    await firestore.collection("chat_rooms").doc(room_id).collection("messages").add(message.fromMessageMap());
    





  }
  Stream<QuerySnapshot> getMessageList(String senderId, String receiverId){
    List<String> ids=[senderId.toString(),receiverId.toString()];
    ids.sort();
    String room_id=ids.join("_");
    return firestore.collection("chat_rooms").doc(room_id).collection("messages")
    .orderBy("dateTime",descending: false).snapshots();

    
  }

  
}