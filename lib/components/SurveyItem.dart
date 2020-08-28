import 'package:SocialSurveys/components/Alternative.dart';
import 'package:flutter/material.dart';

class SurveyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
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
                    "sdufhasdf hashdf kashdf jkasdhfkash dfjkhasdkjfhdas dfhjkasd fhjkash dfjkahsd fjhas kdfhas kjdfh askjdfh skjadfhdh dh kjashf kah kjhdfkashd fkjahsfkha skdf",
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
