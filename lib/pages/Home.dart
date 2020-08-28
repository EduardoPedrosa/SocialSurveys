import 'dart:async';

import 'package:SocialSurveys/pages/CreateSurvey.dart';
import 'package:SocialSurveys/pages/Feed.dart';
import 'package:SocialSurveys/pages/Profile.dart';
import 'package:SocialSurveys/services/Auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({this.userId, this.auth, this.logout});

  final String userId;
  final Auth auth;
  final Function logout;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Feed(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateSurvey(userId: widget.userId)),
          ).then((value) {
            setState(() {
              currentScreen = SizedBox();
            });
            Timer(Duration(milliseconds: 500), () {
              setState(() {
                currentScreen = Feed();
              });
            });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                Feed(); // if user taps on this dashboard tab will be active
                            currentTab = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.dashboard,
                                color: currentTab == 0
                                    ? Colors.purple[700]
                                    : Colors.grey,
                              ),
                              Text(
                                'Feed',
                                style: TextStyle(
                                  color: currentTab == 0
                                      ? Colors.purple[700]
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = Profile(
                              logout: widget.logout,
                            );
                            currentTab = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: currentTab == 1
                                    ? Colors.purple[700]
                                    : Colors.grey,
                              ),
                              Text(
                                'Perfil',
                                style: TextStyle(
                                  color: currentTab == 1
                                      ? Colors.purple[700]
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
