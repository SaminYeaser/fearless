import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../Signup/signup_screen.dart';
import 'components/background.dart';

class LoginScreen extends StatefulWidget {
  Animation<double>? transitionAnimation;

  LoginScreen({this.transitionAnimation});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textEditingControllerEmail = TextEditingController();

  TextEditingController _textEditingControllerPassword = TextEditingController();

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.03),
              AnimatedBuilder(
                animation: widget.transitionAnimation!,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      // X, Y - Origin (0, 0) is in the upper left corner.
                      begin: Offset(-1, 0),
                      end: Offset(0, 0),
                    ).animate(
                      CurvedAnimation(
                        curve: Interval(0, 0.5, curve: Curves.easeOutCubic),
                        parent: widget.transitionAnimation!,
                      ),
                    ),
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                          return 'Please Enter Your Email';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please Enter a Valid Email';
                      }
                      return null;
                    },
                    controller: _textEditingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: kPrimaryColor,),

                        fillColor: kPrimaryLightColor,
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6.0))),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              AnimatedBuilder(
                animation: widget.transitionAnimation!,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      // X, Y - Origin (0, 0) is in the upper left corner.
                      begin: Offset(1, 0),
                      end: Offset(0, 0),
                    ).animate(
                      CurvedAnimation(
                        curve: const Interval(0, 0.5, curve: Curves.easeOutCubic),
                        parent: widget.transitionAnimation!,
                      ),
                    ),
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: _textEditingControllerPassword,
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: kPrimaryColor,),

                        fillColor: kPrimaryLightColor,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6.0))),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: widget.transitionAnimation!,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      // X, Y - Origin (0, 0) is in the upper left corner.
                      begin: Offset(1, 1),
                      end: Offset(0, 0),
                    ).animate(widget.transitionAnimation!),
                    child: child,
                  );
                },
                child: RoundedButton(
                  text: "LOGIN",
                  press: () {},
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
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
        ),
      ),
    );
  }
}
