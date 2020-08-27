import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateSurvey extends StatefulWidget {
  CreateSurvey({this.userId});
  final String userId;

  @override
  _CreateSurveyState createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> {
  String title;
  List<String> alternatives;

  void initState() {
    super.initState();
    alternatives = List<String>();
    alternatives.add("");
    alternatives.add("");
  }

  renderAlternativesInputs() {
    int index = 0;
    return alternatives.map<Widget>((alternative) {
      index++;
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                decoration: new InputDecoration(
                  labelText: "Alternativa $index",
                ),
                onChanged: (String value) {
                  setState(() {
                    alternatives[index - 1] = value;
                  });
                },
              ),
            ),
            alternatives.length > 2
                ? Expanded(
                    child: Center(
                      child: IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        tooltip: "Excluir alternativa",
                        onPressed: () {
                          setState(() {
                            alternatives.removeAt(index - 1);
                          });
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: SizedBox(),
                  )
          ],
        ),
      );
    }).toList();
  }

  submitForm() {
    bool hasEmpty = false;
    alternatives.forEach((element) {
      if (element == "") {
        hasEmpty = true;
      }
    });
    if (hasEmpty) {
      Toast.show("Preencha todos os campos disponíveis", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Questionário'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: new InputDecoration(
                      labelText: "Título",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                ),
                ...renderAlternativesInputs(),
                alternatives.length < 10
                    ? Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 20),
                        child: IconButton(
                          iconSize: 30,
                          color: Colors.purple,
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            setState(() {
                              alternatives.add("");
                            });
                          },
                        ))
                    : SizedBox(
                        height: 60,
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          submitForm();
        },
      ),
    );
  }
}
