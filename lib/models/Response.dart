import 'package:cloud_firestore/cloud_firestore.dart';

class Response {
  
  String documentId;
  String userId;
  String surveyId;
  int alternative;

  Response({this.userId, this.surveyId, this.alternative});

  Response.fromMap(DocumentSnapshot document){
    documentId = document.documentID;
    userId = document.data["userId"];
    surveyId = document.data["surveyId"];
    alternative = document.data["alternative"];
  }

  toJson() {
    return {
      "userId": userId,
      "surveyId": surveyId,
      "alternative": alternative
    };
  }
}