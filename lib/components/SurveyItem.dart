import 'package:SocialSurveys/components/Alternative.dart';
import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/services/ResponseService.dart';
import 'package:flutter/material.dart';

class SurveyItem extends StatefulWidget {
  SurveyItem({this.survey, this.userId});

  final String userId;
  final Survey survey;

  @override
  _SurveyItemState createState() => _SurveyItemState();
}

class _SurveyItemState extends State<SurveyItem> {
  List<double> percents;
  int userAlternative;

  void initState() {
    super.initState();
    percents = widget.survey.percents;
    userAlternative = widget.survey.userAlternative;
  }

  void addResponse(int index) async {
    if (index != userAlternative) {
      List<double> percents = await ResponseService.instance
          .addResponse(widget.userId, widget.survey, index);
      print(percents);
      setState(() {
        percents = percents;
        userAlternative = index;
      });
    }
  }

  List<Widget> loadAlternatives() {
    return widget.survey.alternatives.asMap().entries.map((e) {
      return Alternative(
        text: e.value,
        index: e.key,
        percent: percents == null ? null : widget.survey.percents[e.key],
        userAlternative: userAlternative,
        addResponse: addResponse,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/person.png')),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.survey.user.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    widget.survey.title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[...loadAlternatives()],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
