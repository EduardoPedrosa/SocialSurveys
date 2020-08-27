import 'package:SocialSurveys/models/Survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyService {
  final CollectionReference _collection = Firestore.instance.collection("Surveys");

  SurveyService._privateConstructor();
  static final SurveyService instance = SurveyService._privateConstructor();

  Future<void> addSurvey( String userId, String title, List<String> alternatives) async {
    Survey survey = new Survey(userId: userId, title: title, alternatives: alternatives);
    await _collection.add(survey.toJson());
  }
}