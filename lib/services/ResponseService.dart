
import 'package:SocialSurveys/models/Response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseService {
  final CollectionReference _collection = Firestore.instance.collection("Surveys");

  ResponseService._privateConstructor();
  static final ResponseService instance = ResponseService._privateConstructor();

  Future<List> addResponse(String userId, String surveyId, int alternative) async {
    Response response = new Response(userId: userId, surveyId: surveyId, alternative: alternative);
    await _collection.add(response.toJson());
    // List<double> percents;
  }
}