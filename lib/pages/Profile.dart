import 'package:SocialSurveys/models/Survey.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({this.logout});
  final Function logout;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() {
    try {
      widget.logout();
    } catch (e) {
      print(e);
    }
  }

  void _select(String choice) {
    if (choice == "Sair da conta") {
      signOut();
    }
  }

  Widget survey() {
    return Card(
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.visibility),
                  Text("30", style: TextStyle(fontSize: 20)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Questwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwionário 1",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
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
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nome",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "email@email.com",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            // Estatísticas -----------------------------------------------
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
                              "10",
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
                              "3",
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
                child: ListView(
                  children: <Widget>[survey(), survey()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
