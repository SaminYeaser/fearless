import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'Screens/Welcome/components/body.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Management System',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'OpenSans'
      ),
      home: AnimatedSplashScreen(
        backgroundColor: kPrimaryLightColor,
        duration: 3000,
          nextScreen: WelcomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.scale,
          splash: Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/icons/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),),
    );
  }
}
