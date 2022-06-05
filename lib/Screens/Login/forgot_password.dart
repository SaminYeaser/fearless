import 'package:fearless/Screens/Login/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({Key? key}) : super(key: key);

   TextEditingController _passwordResetEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: kPrimaryColor,),
        ),
      ),
      body: Background(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
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
                  controller: _passwordResetEmail,
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
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  resetPassword();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Reset Password', style: TextStyle(
                            color: Colors.white
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
   Future resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _passwordResetEmail.text.trim());
      Fluttertoast.showToast(msg: 'Email send to the mail');
    } on FirebaseException catch(e){
      Fluttertoast.showToast(msg: e.message!);
    }

   }
}
