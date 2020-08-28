import 'package:SocialSurveys/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Survey {
  String documentId;
  String userId;
  String title;
  bool isVisible;
  List<String> alternatives;
  User user;

  Survey({this.title, this.userId, this.isVisible = true, this.alternatives});

  Survey.fromMap(DocumentSnapshot document, User user) {
    documentId = document.documentID;
    title = document.data["title"];
    userId = document.data["userId"];
    alternatives = List<String>();
    document.data["alternatives"]
        .forEach((alternative) => alternatives.add(alternative.toString()));
    this.user = user;
  }

  toJson() {
    return {
      "title": title,
      "userId": userId,
      "createdAt": Timestamp.now(),
      "isVisible": isVisible,
      "alternatives": alternatives
    };
  }
}
