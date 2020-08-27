import 'package:SocialSurveys/models/Survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserSurvey extends Survey {
  
  String userId;
  
  UserSurvey({this.userId}): super();

  UserSurvey.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    userId = document.data["userId"];
    title = document.data["title"];
    description = document.data["description"];
    alternatives = document.data["alternatives"];
  }

  toJson() {
    return {
      "title": title,
      "userId": userId,
      "description": description,
      "alternatives": alternatives
    };
  }
}