import 'package:SocialSurveys/components/SurveyItem.dart';
import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/services/SurveyService.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Survey> surveys;

  void initState() {
    super.initState();
    surveys = List<Survey>();

    fetchSurveys();
  }

  void fetchSurveys() async {
    String lastSurveyId =
        surveys.length > 0 ? surveys[surveys.length - 1].documentId : null;

    List<Survey> listOfSurveys =
        await SurveyService.instance.getAllSurveys(lastSurveyId);

    print(listOfSurveys);

    setState(() {
      surveys = listOfSurveys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialSurveys'),
      ),
      body: ListView(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...surveys
                .map((survey) => (SurveyItem(
                      survey: survey,
                    )))
                .toList(),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ]),
    );
  }
}
