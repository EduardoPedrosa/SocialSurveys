import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  
  String documentId;
  String name;

  User({this.name});

  User.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    name = document.data["name"];
  }

  toJson() {
    return {
      "name": name
    };
  }
}