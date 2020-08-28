import 'package:flutter/material.dart';

class Alternative extends StatelessWidget {
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[300],
                          ),
                          width:
                              MediaQuery.of(context).size.width * 0.23 * 0.65,
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
                            "aaaaaaaaaaaaadasfasdfasdfasdfasdfssdfsdfasdfasdfasfasdfaaaaaaa",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Container(
                                width: 30,
                                child: Text(
                                  "23%",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
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
              value: false,
              onChanged: (value) {},
            )),
      ],
    );
  }
}
