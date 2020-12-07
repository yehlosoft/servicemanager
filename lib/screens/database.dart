import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {

  String station;

  getStation(String station) {
    this.station = station;
  }

  staExist(String chatRoomId, messageMap)
  {
    print("Yahan Tak Sab Aaaya Hai");
    if(FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId) != null)
      {
        print("Chat Room Exists");
        addConversationMessages(chatRoomId, messageMap);
      }
    else
      {
        print("Chat Room does not Exists");
        createChatRoom(chatRoomId, messageMap);
    }
  }
  createChatRoom(String chatRoomId, messageMap) async
  {
   await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(messageMap);

  }

  addConversationMessages(String chatRoomId, messageMap) {
    print(chatRoomId);
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection(
        "chats").add(
        messageMap);
  }
  getConversationMessages(String chatRoomId) async {
    print(chatRoomId);
    return  FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").orderBy("time", descending: false).snapshots();
  }
}