import 'package:SocialSurveys/components/SurveyItem.dart';
import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/services/SurveyService.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Feed extends StatefulWidget {
  Feed({this.userId});
  final String userId;

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Survey> surveys;
  bool isLoading = false;

  void initState() {
    super.initState();
    surveys = List<Survey>();

    fetchSurveys();
  }

  Future<void> fetchSurveys() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String lastSurveyId;
      if (surveys.length > 0) {
        lastSurveyId = surveys[surveys.length - 1].documentId;
      }

      List<Survey> listOfSurveys = await SurveyService.instance
          .getAllSurveys(lastSurveyId, widget.userId);

      setState(() {
        listOfSurveys.forEach((element) {
          surveys.add(element);
        });

        isLoading = false;
      });
    }
  }

  Future<Null> handleRefresh() async {
    if (!isLoading) {
      String lastSurveyId =
          surveys.length > 0 ? surveys[surveys.length - 1].documentId : null;

      List<Survey> listOfSurveys = await SurveyService.instance
          .getAllSurveys(lastSurveyId, widget.userId);

      setState(() {
        surveys.clear();
        listOfSurveys.forEach((element) {
          surveys.add(element);
        });
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialSurveys'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchSurveys();
            return true;
          }
          return false;
        },
        child: RefreshIndicator(
            onRefresh: handleRefresh,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: surveys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SurveyItem(
                          survey: surveys[index],
                          userId: widget.userId,
                        );
                      }),
                  isLoading
                      ? Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: Loading(
                              indicator: BallPulseIndicator(),
                              size: 50.0,
                              color: Colors.purple),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
