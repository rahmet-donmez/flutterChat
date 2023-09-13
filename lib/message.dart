class Message {
 late final String messageText;
  late final String senderId;
  late final String receiverId;
  late final DateTime dateTime;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.messageText,
    required this.dateTime


  });
  Map<String,dynamic> fromMessageMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'messageText':messageText,
      'dateTime':dateTime

    };
  }
  
  
}