import 'package:SocialSurveys/models/Survey.dart';
import 'package:SocialSurveys/models/User.dart';
import 'package:flutter/material.dart';
import 'package:SocialSurveys/services/SurveyService.dart';
import 'package:SocialSurveys/services/UserService.dart';

class SurveyComp extends StatefulWidget {
  SurveyComp({this.survey});
  final Survey survey;

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<SurveyComp> {
  bool visible = true;

  void initState() {
    super.initState();
    print(widget.survey.toJson());
    // setState(() {
    //   visible = widget.survey.isVisible;
    // });
  }

  void handleChangeVisibility() {
    if (visible) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  void handleNavigateToSurvey() {}

  @override
  Widget build(BuildContext context) {
    if (widget.survey == null) return Container();
    return Card(
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: visible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: handleChangeVisibility,
                  ),
                  Text("30", style: TextStyle(fontSize: 20)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  widget.survey.title,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )),
    );
  }
}

class Profile extends StatefulWidget {
  Profile({this.userId, this.logout});
  final String userId;
  final Function logout;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Survey> surveys;
  User user;

  void initState() {
    super.initState();
    surveys = List<Survey>();

    fetchSurveys();
    fetchUser();
  }

  @override
  void didUpdateWidget(Profile oldWidget) {
    if (oldWidget != widget) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  signOut() {
    try {
      widget.logout();
    } catch (e) {
      print(e);
    }
  }

  void fetchSurveys() async {
    List<Survey> listOfSurveys =
        await SurveyService.instance.getUserSurveys(widget.userId);

    listOfSurveys.forEach((element) {
      print(element.toJson());
    });

    setState(() {
      surveys = listOfSurveys;
    });
  }

  void fetchUser() async {
    User me = await UserService.instance.getUser(widget.userId);

    print(me.toJson());

    setState(() {
      user = me;
    });
  }

  void _select(String choice) {
    if (choice == "Sair da conta") {
      signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    var numOfVisibles = 0;
    // for (Survey s in surveys) {
    //   if (s.isVisible) numOfVisibles += 1;
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return ["Sair da conta"].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: user == null
          ? Container()
          : Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/person.png')),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            user.email,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  child: Center(
                                      child: Text(
                                    surveys.length.toString(),
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Criados",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  child: Center(
                                      child: Text(
                                    "20",
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Respondidos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  child: Center(
                                      child: Text(
                                    numOfVisibles.toString(),
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 37,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Visíveis",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                          itemCount: surveys.length,
                          itemBuilder: (context, index) => SurveyComp(
                                survey: surveys[index],
                              )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
