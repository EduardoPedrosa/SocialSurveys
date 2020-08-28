import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/models/User.dart';
import 'package:SocialSurveys/services/UserService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const SURVER_BY_PAGE = 5;

class SurveyService {
  final CollectionReference _collection =
      Firestore.instance.collection("Surveys");

  SurveyService._privateConstructor();
  static final SurveyService instance = SurveyService._privateConstructor();

  Future<void> addSurvey(
      String userId, String title, List<String> alternatives) async {
    Survey survey =
        new Survey(userId: userId, title: title, alternatives: alternatives);
    await _collection.add(survey.toJson());
  }

  Future<List> getAllSurveys(String lastSurveyId) async {
    Query query = _collection
        .orderBy("createdAt", descending: true)
        .limit(SURVER_BY_PAGE);
    if (lastSurveyId != null) {
      DocumentSnapshot lastDocSp =
          await _collection.document(lastSurveyId).get();
      query = query.startAfterDocument(lastDocSp);
    }
    QuerySnapshot sp = await query.getDocuments();
    List<Survey> surveys = List<Survey>();
    for(DocumentSnapshot doc in sp.documents){
      User user = await UserService.instance.getUser(doc["userId"]);
      surveys.add(Survey.fromMap(doc, user));
    }
    return surveys;
  }

  Future<List> getUserSurveys(String userId) async {
    QuerySnapshot sp = await _collection
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .getDocuments();
    List<Survey> surveys = List<Survey>();
    for(DocumentSnapshot doc in sp.documents){
      User user = await UserService.instance.getUser(doc["userId"]);
      surveys.add(Survey.fromMap(doc, user));
    }
    return surveys;
  }
}
