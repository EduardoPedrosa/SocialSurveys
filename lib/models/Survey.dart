import 'package:cloud_firestore/cloud_firestore.dart';

class Survey{
  
  String documentId;
  String title;
  String description;
  List<String> alternatives = []; 
  
  Survey({this.title, this.description, this.alternatives});

  Survey.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    title = document.data["title"];
    description = document.data["description"];
    alternatives = document.data["alternatives"];
  }

  toJson() {
    return {
      "title": title,
      "description": description,
      "alternatives": alternatives
    };
  }
}