import 'package:SocialSurveys/pages/RootPage.dart';
import 'package:SocialSurveys/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as Splash;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Splash.SplashScreen(
      seconds: 3,
      navigateAfterSeconds: RootPage(auth: new Auth()),
      title: Text(
        'SocialSurveys',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      image: Image(
        image: AssetImage('assets/icons/survey.png'),
      ),
      photoSize: 60,
      backgroundColor: Colors.purple[700],
      loaderColor: Colors.white,
    );
  }
}
