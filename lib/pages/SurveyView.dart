import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/services/ResponseService.dart';
import 'package:SocialSurveys/services/SurveyService.dart';
import 'package:flutter/material.dart';

class SurveyView extends StatefulWidget {
  SurveyView({this.survey});
  final Survey survey;

  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  List<double> percents;

  void handleDeleteSurvey() async {
    await SurveyService.instance.deleteSurvey(widget.survey.documentId);
    Navigator.pop(context);
  }

  Widget alternative(int index) {
    print(widget.survey.toJson());
    return (Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.purple[100],
                          ),
                          width: percents != null
                              ? MediaQuery.of(context).size.width *
                                  percents[index] *
                                  0.75
                              : 0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            widget.survey.title,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 60,
                              child: Text(
                                percents != null
                                    ? "${(percents[index] * 100).toInt()}%"
                                    : "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    fetchPercents();
  }

  void fetchPercents() async {
    var p = await ResponseService.instance.getVotesPercent(widget.survey);
    setState(() {
      percents = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enquete'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text("Visibilidade: " +
                    (widget.survey.isVisible ? "Visível" : "Invisível")),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Center(
                        child: Text(
                      widget.survey.responseCount.toString(),
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 37,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Respostas",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                                  return alternative(index);
                                }),
                          )
                        ],
                      )),
                ),
              ),
              Center(
                child: RaisedButton(
                    color: Colors.red,
                    child: Text(
                      "Excluir enquete",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: handleDeleteSurvey),
              ),
            ],
          ),
        ));
  }
}
