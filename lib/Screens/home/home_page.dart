import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fearless/Screens/Welcome/components/body.dart';
import 'package:fearless/constants.dart';
import 'package:fearless/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

Widget? menuItem(String name, IconData icon){
  return InkWell(
    onTap: (){},
    child: Container(
      height: 40,
      color: Colors.grey[300],
      child: Row(
        children:  [
          Expanded(child: Icon(icon, color: kPrimaryColor,size: 16,)),
          const SizedBox(width: 30),
          Expanded(
            child: Text(name, style: const TextStyle(
                fontSize: 16
            ),),
          )
        ],
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUserModel = UserModel();
  bool selected = false;

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
      drawer: Drawer(
        backgroundColor: kPrimaryLightColor,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 200,),
                  menuItem('home', Icons.home)!
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Fearless'),
        titleSpacing: 0,
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
