import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  
  String documentId;
  String name;
  String email;

  User({this.name, this.email});

  User.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    name = document.data["name"];
    email = document.data["email"];
  }

  toJson() {
    return {
      "name": name,
      "email": email
    };
  }
}