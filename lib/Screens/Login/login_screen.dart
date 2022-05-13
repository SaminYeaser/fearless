import 'package:fearless/controllers/login/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../Signup/signup_screen.dart';
import '../home/home_page.dart';
import 'components/background.dart';

class LoginScreen extends StatefulWidget {
  Animation<double>? transitionAnimation;

  LoginScreen({this.transitionAnimation});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController _loginController = Get.put(LoginController());
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _textEditingControllerEmail = TextEditingController();

  final TextEditingController _textEditingControllerPassword = TextEditingController();

  final auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
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
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),

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
                      validator: (value){
                        RegExp regex =  RegExp(r'^.{8,}$');
                        if(value!.isEmpty){
                          return 'Password is Required';
                        }
                        if(!regex.hasMatch(value)){
                          return 'Please Enter Valid Password(minimum: 8 character)';
                        }
                      },
                      controller: _textEditingControllerPassword,
                      onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: kPrimaryColor,),

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
                    press: () {
                      _signIn(_textEditingControllerEmail.text, _textEditingControllerPassword.text);
                    },
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
      ),
    );
  }
  void _signIn(String email, String password) async{
    if(_formkey.currentState!.validate()){
      try{
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        await storage.write(key: 'uid', value: userCredential.user?.uid);
        Get.offAll(const HomePage());
      } on FirebaseAuthException catch(e){
        // print(e.code);
        //   if(e.code == 'user-not-found'){
        //
        //
        //   }
        Fluttertoast.showToast(msg: 'No User Found');
      }

      // }).catchError((e){
      // });
    }
  }
}
