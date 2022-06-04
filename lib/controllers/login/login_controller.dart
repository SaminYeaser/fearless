import 'dart:io';

import 'package:fearless/model/article.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginController extends GetxController{
  final auth = FirebaseAuth.instance;

  final textEditingControllerEmail = TextEditingController().obs;
  final textEditingControllerPassword = TextEditingController().obs;
  final textEditingControllerFirstName = TextEditingController().obs;
  final articleController = TextEditingController().obs;
  final textEditingControllerSecondName = TextEditingController().obs;
  Rx articles = ArticlesModel().obs;
  final image = Rxn<File>();
  Rx<DatabaseReference> databaseReference = FirebaseDatabase.instance.ref().child('articles').obs;

  @override
  void onReady() {
    super.onReady();
    databaseReference = FirebaseDatabase.instance.ref().child('articles').obs;
  }


   signIn(String email, String password) async{
     await auth.signInWithEmailAndPassword(email: email, password: password).then((uid){
      return uid;
    }).catchError((e){
      return e;
    });
  }
}