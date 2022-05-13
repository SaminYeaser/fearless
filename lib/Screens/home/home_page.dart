import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fearless/Screens/Welcome/components/body.dart';
import 'package:fearless/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUserModel = UserModel();

  @override
  void initState() {
    FirebaseFirestore.instance.
    collection('users').
    doc(user?.uid).get().then((value){
      this.loggedInUserModel = UserModel.fromMap(value.data());
      setState(() {

      });
    });
    super.initState();
  }

  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fearless'),
        actions: [
          IconButton(onPressed: () async{
            FirebaseAuth.instance.signOut();
            await storage.delete(key: 'uid');
            Get.off(WelcomeScreen());
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
