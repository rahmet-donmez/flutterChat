import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/chatService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatRoomView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatRoomView();
}

class _ChatRoomView extends State<ChatRoomView> {
  ini()async{
 await Firebase.initializeApp();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
  }
  TextEditingController messageText = TextEditingController();
  ChatService chatService=new ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
        leading: Icon(Icons.chat_bubble_outlined),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          dialog(),
          SizedBox(
            height: 5,
          ),
          
          messageWrite(),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
Widget messageItem(DocumentSnapshot doc){
  Map<String,dynamic> data=doc.data() as Map<String, dynamic>;
  if(data["senderId"]=="MjkkcUlLGfOE3UsEE84ldCcZLSJ3"){
    return Container(
      padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.5,top:10),

    width: MediaQuery.of(context).size.width*0.5,
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(5),
      color: Color.fromARGB(255, 183, 149, 241)
    ),
    alignment: Alignment.bottomRight,
    
    child: Text(data["messageText"]));



  }

  return Container(
    padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.5,top: 10),

    width: MediaQuery.of(context).size.width*0.5,
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(5),
      color: Color.fromARGB(255, 183, 149, 241)
    ),
    alignment: Alignment.bottomLeft,
    
    child: Text(data["messageText"]));


}
  Widget dialog() {
    return Expanded(
        child: Container(
     // decoration: BoxDecoration(color: Colors.grey),
      child: StreamBuilder(
      stream: chatService.getMessageList("MjkkcUlLGfOE3UsEE84ldCcZLSJ3", "KgPVLyx1BHfsO6GshV30oV6LAwm1"),
      builder: (context, snapshot) {
        if(snapshot.data==null){
          return CircularProgressIndicator();
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else{
          return ListView(
          children: snapshot.data!.docs.map((e) => messageItem(e)).toList(),
        );
        }
        
      },)
    ));
  }

  Widget messageWrite() {
    return Row(
      children: [
        SizedBox(
          width: 25,
        ),
        Expanded(
          child: TextField(
            controller: messageText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 5, color: Colors.deepPurple)),
              hintText: "mesajınızı yazın",
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        IconButton(
          onPressed: () {
            chatService.sendMessagge(messageText.text);

          },
          icon: Icon(Icons.send),
          color: Colors.deepPurple,
        )
      ],
    );
  }
}
