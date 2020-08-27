import 'package:cloud_firestore/cloud_firestore.dart';

class Survey{
  
  String documentId;
  String userId;
  String title;
  bool isVisible;
  List<String> alternatives;
  
  Survey({this.title, this.userId, this.isVisible=true, this.alternatives});

  Survey.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    title = document.data["title"];
    userId = document.data["userId"];
    alternatives = document.data["alternatives"];
  }

  toJson() {
    return {
      "title": title,
      "userId": userId,
      "alternatives": alternatives
    };
  }
}