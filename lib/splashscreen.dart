import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as Splash;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Splash.SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomePage(title: 'Calculadora'),
      title: Text(
        'SocialSurveys',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      image: Image(
        image: AssetImage('assets/icons/survey.png'),
      ),
      photoSize: 100,
      backgroundColor: Colors.purple[700],
      loaderColor: Colors.white,
    );
  }
}
