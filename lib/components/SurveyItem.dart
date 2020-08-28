import 'package:SocialSurveys/components/Alternative.dart';
import 'package:SocialSurveys/models/Survey.dart';
import 'package:flutter/material.dart';

class SurveyItem extends StatefulWidget {
  SurveyItem({this.survey});

  final Survey survey;

  @override
  _SurveyItemState createState() => _SurveyItemState();
}

class _SurveyItemState extends State<SurveyItem> {
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
                        "Nome da pessoa",
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
                    children: <Widget>[
                      Alternative(),
                      Alternative(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
