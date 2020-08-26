import 'package:SocialSurveys/services/Auth.dart';
import 'package:SocialSurveys/pages/HomePageTest.dart';
import 'package:SocialSurveys/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  DESCONHECIDO,
  DESLOGADO,
  LOGADO,
}

class RootPage extends StatefulWidget {
  final Auth auth;

  RootPage({this.auth});

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.DESCONHECIDO;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getUser().then((user) {
      setState(() {
      if (user != null) {
        _userId = user?.uid;
      }
      authStatus = user?.uid == null ? 
        AuthStatus.DESLOGADO : 
        AuthStatus.LOGADO;
      });
    });
  }

  void login() async {
    FirebaseUser user = await widget.auth.getUser();
    setState(() {
      _userId = user.uid.toString();
      authStatus = AuthStatus.LOGADO;
    });
  }

  void logout() {
    setState(() {
      authStatus = AuthStatus.DESLOGADO;
      _userId = "";
    });
  }

  Widget showLoadingIndicator() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.DESCONHECIDO:
        return showLoadingIndicator();
        break;
      case AuthStatus.DESLOGADO:
        return new LoginPage(
          auth: widget.auth,
          login: login
        );
        break;
      case AuthStatus.LOGADO:
        if (_userId.length > 0 && _userId != null) {
          return new MyHomePage(
            userId: _userId,
            auth: widget.auth,
            logout: logout
          );
        } else
          return showLoadingIndicator();
        break;
      default:
        return showLoadingIndicator();
    }
  }
}
