import 'package:flutter/material.dart';

class Alternative extends StatefulWidget {
  Alternative(
      {this.text,
      this.index,
      this.percent,
      this.userAlternative,
      this.addResponse,
      this.changedCurrentChecked});
  final String text;
  final int index;
  final double percent;
  final int userAlternative;
  final Function(int) addResponse;
  final Function(int) changedCurrentChecked;

  @override
  _AlternativeState createState() => _AlternativeState();
}

class _AlternativeState extends State<Alternative> {
  bool hasResponse = false;
  bool checked = false;

  void initState() {
    super.initState();
    verifyIfHasResponse();
  }

  verifyIfHasResponse() {
    if (widget.percent != null && widget.userAlternative != null) {
      setState(() {
        hasResponse = true;
        if (widget.userAlternative == widget.index) {
          checked = true;
        } else {
          checked = false;
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant Alternative oldWidget) {
    if (oldWidget.userAlternative != widget.userAlternative ||
        oldWidget.percent != widget.percent) {
      verifyIfHasResponse();
    }
    super.didUpdateWidget(oldWidget);
  }

  void handleCheck() {
    widget.addResponse(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:
                                checked ? Colors.purple[100] : Colors.grey[300],
                          ),
                          width: hasResponse
                              ? MediaQuery.of(context).size.width *
                                  widget.percent *
                                  0.65
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
                            widget.text,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 50,
                              child: Text(
                                hasResponse
                                    ? "${(widget.percent * 100).toInt()}%"
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
        Container(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Checkbox(
              value: checked,
              onChanged: (value) {
                handleCheck();
                setState(() {
                  if (value) {
                    checked = true;
                    widget.changedCurrentChecked(widget.index);
                  }
                });
              },
            )),
      ],
    );
  }
}
