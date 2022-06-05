import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fearless/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../bottom_nav.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../constants.dart';
import '../Login/components/background.dart';
import '../Login/login_screen.dart';

import '../home/home_page.dart';
import 'components/or_divider.dart';
import 'components/social_icon.dart';


class SignUpScreen extends StatelessWidget {

  final TextEditingController _mailTextEditingController = TextEditingController();
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _secondNameTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  RxInt passwordObsecure = 0.obs;
  RxInt confirmPasswordObsecure = 0.obs;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "SIGNUP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      TextFormField(
                          validator: (value){
                            RegExp regex =  RegExp(r'^.{3,}$');
                            if(value!.isEmpty){
                              return 'First Name more than 3 character are Required';
                            }
                            if(!regex.hasMatch(value)){
                              return 'First Name more than 3 character are Required';
                            }
                          },
                        controller: _firstNameTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),

                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'FirstName',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0))),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value){
                          RegExp regex =  RegExp(r'^.{3,}$');
                          if(value!.isEmpty){
                            return 'Second Name more than 3 character are Required';
                          }
                          if(!regex.hasMatch(value)){
                            return 'Second Name more than 3 character are Required';
                          }
                        },
                        controller: _secondNameTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),

                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'Second Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0))),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter Your Email';
                          }
                          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)){
                            return 'Please Enter a Valid Email';
                          }
                          return null;
                        },
                        controller: _mailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail, color: kPrimaryColor,),

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
                      SizedBox(height: 10),
                      Obx(()=>TextFormField(
                        validator: (value){
                          RegExp regex =  RegExp(r'^.{8,}$');
                          if(value!.isEmpty){
                            return 'Password is Required';
                          }
                          if(!regex.hasMatch(value)){
                            return 'Please Enter Valid Password(minimum: 8 character)';
                          }
                        },
                        controller: _passwordTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: passwordObsecure.value == 0 ? true : false,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
                            suffixIcon: passwordObsecure.value == 0 ?  IconButton(
                              onPressed: (){
                                passwordObsecure.value = 1;
                              },
                              icon: Icon(Icons.visibility),
                              color: kPrimaryColor,
                            ) : IconButton(
                              onPressed: (){
                                passwordObsecure.value = 0;
                              },
                              icon: Icon(Icons.visibility_off),
                              color: kPrimaryColor,
                            ),
                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0))),
                      ),),
                      SizedBox(height: 10),
                      Obx(()=>TextFormField(
                        validator: (value){
                          if(_passwordTextEditingController.text != _confirmPasswordTextEditingController.text){
                            return 'Password don\'t match';
                          }
                          return null;
                        },
                        controller: _confirmPasswordTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: confirmPasswordObsecure.value == 0 ? true : false,
                        onChanged: (value) {},
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
                            suffixIcon: confirmPasswordObsecure.value == 0 ?
                            IconButton(
                              onPressed: (){
                                confirmPasswordObsecure.value = 1;
                              },
                              icon: Icon(Icons.visibility),color: kPrimaryColor,) :
                            IconButton(
                              onPressed: (){
                                confirmPasswordObsecure.value = 0;
                              },
                              icon: Icon(Icons.visibility_off),color: kPrimaryColor,),
                            fillColor: kPrimaryLightColor,
                            filled: true,
                            hintText: 'Confirm Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6.0))),
                      )),
                      RoundedButton(
                        text: "SIGNUP",
                        press: () {
                          _signIn(_mailTextEditingController.text, _passwordTextEditingController.text, context);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
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
                      OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocalIcon(
                            iconSrc: "assets/icons/facebook.svg",
                            press: () {
                              Fluttertoast.showToast(msg: 'Coming Soon');
                            },
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/twitter.svg",
                            press: () {
                              Fluttertoast.showToast(msg: 'Coming Soon');
                            },
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/google-plus.svg",
                            press: () {
                              Fluttertoast.showToast(msg: 'Coming Soon');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _signIn(String email,String password, BuildContext context) async{
    if(_formkey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password).
      then((value) {
        postDetailsFireStore(context);
        }).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsFireStore(BuildContext context) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.firstName = _firstNameTextEditingController.text;
    userModel.secondName = _secondNameTextEditingController.text;
    userModel.uid = user.uid;

    await firebaseFirestore.collection('users').doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => new BottomNav()));
  }
}
