import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fearless/Screens/home/home_page.dart';
import 'package:fearless/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'Screens/Welcome/components/body.dart';
import 'binding.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final storage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key: 'uid');
    if(value == null){
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Management System',
      initialBinding: InitialBinding(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'OpenSans'
      ),
      home: AnimatedSplashScreen(
        backgroundColor: kPrimaryLightColor,
        duration: 3000,
          nextScreen:  FutureBuilder(
            future: checkLoginStatus(),
            builder: (BuildContext context, AsyncSnapshot<bool>snapshot){
              if(snapshot.data == false){
                return WelcomeScreen();
              }else{
                return BottomNav();
              }
              // if(snapshot.connectionState == ConnectionState.waiting){
              //   return const Center(child: CircularProgressIndicator(),);
              // }

            },
          ),
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
