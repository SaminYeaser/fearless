import 'package:fearless/model/article.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginController extends GetxController{
  final auth = FirebaseAuth.instance;

  final textEditingControllerEmail = TextEditingController().obs;
  final textEditingControllerPassword = TextEditingController().obs;
  final textEditingControllerFirstName = TextEditingController().obs;

  final textEditingControllerSecondName = TextEditingController().obs;
  Rx articles = ArticlesModel().obs;

   signIn(String email, String password) async{
     await auth.signInWithEmailAndPassword(email: email, password: password).then((uid){
      return uid;
    }).catchError((e){
      return e;
    });
  }
}