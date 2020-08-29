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
  List<String> alternatives;

  void initState() {
    super.initState();
    percents = widget.survey.percents;
    userAlternative = widget.survey.userAlternative;
    alternatives = List<String>();
    widget.survey.alternatives.forEach((element) {
      alternatives.add(element);
    });
  }

  void addResponse(int index) async {
    if (index != userAlternative) {
      List<double> pc = await ResponseService.instance
          .addResponse(widget.userId, widget.survey, index);

      setState(() {
        percents = pc;
        userAlternative = index;
        alternatives.add("");
        alternatives.removeLast();
      });
    }
  }

  changeCurrentChecked(int index) {
    setState(() {
      userAlternative = index;
    });
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
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.survey.alternatives.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Alternative(
                          text: widget.survey.alternatives[index],
                          index: index,
                          percent: percents == null ? null : percents[index],
                          userAlternative: userAlternative,
                          addResponse: addResponse,
                          changedCurrentChecked: changeCurrentChecked,
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}
