import 'package:SocialSurveys/models/Survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const SURVER_BY_PAGE=5;

class SurveyService {
  final CollectionReference _collection = Firestore.instance.collection("Surveys");

  SurveyService._privateConstructor();
  static final SurveyService instance = SurveyService._privateConstructor();

  Future<void> addSurvey( String userId, String title, List<String> alternatives) async {
    Survey survey = new Survey(userId: userId, title: title, alternatives: alternatives);
    await _collection.add(survey.toJson());
  }

  Future<List> getAllSurveys(String lastSurveyId) async {
    DocumentSnapshot lastDocSp = await _collection.document(lastSurveyId).get();
    QuerySnapshot sp = 
      await _collection
        .orderBy("createdAt", descending: true)
        .startAfterDocument(lastDocSp)
        .limit(SURVER_BY_PAGE)
        .getDocuments();
    List<Survey> surveys = sp.documents.map((doc) => Survey.fromMap(doc));
    return surveys;
  }

  Future<List> getUserSurveys(String userId) async {
    QuerySnapshot sp = 
      await _collection
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .getDocuments();
    List<Survey> surveys = sp.documents.map((doc) => Survey.fromMap(doc));
    return surveys;
  }
}