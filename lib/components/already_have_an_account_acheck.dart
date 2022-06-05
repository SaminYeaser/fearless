import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/Login/forgot_password.dart';
import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        login ?
        InkWell(
          onTap: (){
            Get.to(ForgotPassword());
          },
          child: Text(
            'Forgot Password?',
            style: const TextStyle(color: kPrimaryColor),
          ),
        ) : Container(),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              login ? "Don’t have an Account ? " : "Already have an Account ? ",
              style: const TextStyle(color: kPrimaryColor),
            ),
            GestureDetector(
              onTap: press,
              child: Text(
                login ? "Sign Up" : "Sign In",
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
