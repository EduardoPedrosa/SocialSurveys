
import 'package:SocialSurveys/models/Response.dart';
import 'package:SocialSurveys/models/Survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseService {
  final CollectionReference _collection = Firestore.instance.collection("Responses");

  ResponseService._privateConstructor();
  static final ResponseService instance = ResponseService._privateConstructor();

  Future<List> addResponse(String userId, Survey survey, int alternative) async {
    Response response = new Response(userId: userId, surveyId: survey.documentId, alternative: alternative);
    QuerySnapshot userSurvey = await _collection
      .where("userId", isEqualTo: userId)
      .where("surveyId", isEqualTo: survey.documentId)
      .getDocuments();
    int userSurveyCount = userSurvey.documents.length;
    bool hasResponse = userSurveyCount > 0 ? true : false;
    hasResponse ? 
      await _collection.add(response.toJson()) : 
      await _collection.document(userSurvey.documents[0]["documentId"]).updateData(response.toJson());
    return await getVotesPercent(survey);
  }

  Future<List> getVotesPercent(Survey survey) async {
    QuerySnapshot responsesSp = await _collection.where("surveyId", isEqualTo: survey.documentId).getDocuments();
    List<Response> responses = new List<Response>();
    for(DocumentSnapshot doc in responsesSp.documents){
      responses.add(Response.fromMap(doc));
    }
    int alternativesLength = survey.alternatives.length;
    List<int> responsesCount = List.filled(alternativesLength, 0);
    responses.forEach((response) { 
      ++responsesCount[response.alternative];
    });
    List<double> percents = new List<double>();
    for(int responseCount in responsesCount){
      double percent = (responseCount / alternativesLength);
      percents.add(percent);
    }
    return percents;
  }

  Future<bool> userHasResponse(String userId, String surveyId) async {
    QuerySnapshot userSurvey = await _collection
      .where("userId", isEqualTo: userId)
      .where("surveyId", isEqualTo: surveyId)
      .getDocuments();
    int userSurveyCount = userSurvey.documents.length;
    return userSurveyCount > 0 ? true : false;
  }
}