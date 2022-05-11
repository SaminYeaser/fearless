import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    Center(
                      child: Text(
                        "Fearless",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    // SizedBox(height: 100,),
                    // Image.asset('assets/icons/logo.png', width: 200,height: 200,),
                  ],
                ),
              ),
              
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      text: "LOGIN",
                      press: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return LoginScreen(
                              transitionAnimation: animation,
                            );
                          },
                          transitionDuration: Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(5.0, 5.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));
                      },
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      color: kPrimaryLightColor,
                      textColor: Colors.black,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
