import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/login/login_controller.dart';

class EditPost extends StatelessWidget {
  String? snapshotKey;
  String? story;
  final editArticleController = TextEditingController();
   EditPost({this.snapshotKey, this.story});
  final _formKey = GlobalKey<FormState>();
   LoginController _loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    editArticleController.text = story!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Edit Post'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('First Name'),
                  // TextFormField(
                  //   // validator: (value){
                  //   //   RegExp regex =  RegExp(r'^.{50,}$');
                  //   //   if(value!.isEmpty){
                  //   //     return 'Article more than 50 character are Required';
                  //   //   }
                  //   //   if(!regex.hasMatch(value)){
                  //   //     return 'Article more than 50 character are Required';
                  //   //   }
                  //   // },
                  //   controller: _loginController.textEditingControllerFirstName.value,
                  //   keyboardType: TextInputType.emailAddress,
                  //   onChanged: (value) {},
                  //   // maxLines: 99999 ,
                  //   cursorColor: kPrimaryColor,
                  //   decoration: InputDecoration(
                  //       fillColor: kPrimaryLightColor,
                  //       filled: true,
                  //       // hintText: 'Type here...',
                  //       border: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(6)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(6.0))),
                  // ),
                  // SizedBox(height: 10,),
                  // Text('Second Name'),
                  // TextFormField(
                  //   // validator: (value){
                  //   //   RegExp regex =  RegExp(r'^.{50,}$');
                  //   //   if(value!.isEmpty){
                  //   //     return 'Article more than 50 character are Required';
                  //   //   }
                  //   //   if(!regex.hasMatch(value)){
                  //   //     return 'Article more than 50 character are Required';
                  //   //   }
                  //   // },
                  //   controller: _loginController.textEditingControllerSecondName.value,
                  //   keyboardType: TextInputType.emailAddress,
                  //   onChanged: (value) {},
                  //   // maxLines: 99999 ,
                  //   cursorColor: kPrimaryColor,
                  //   decoration: InputDecoration(
                  //       fillColor: kPrimaryLightColor,
                  //       filled: true,
                  //       hintText: 'Type here...',
                  //       border: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(6)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(6.0))),
                  // ),
                  // SizedBox(height: 10,),
                  Text('Article'),
                  TextFormField(
                    // validator: (value){
                    //   RegExp regex =  RegExp(r'^.{50,}$');
                    //   if(value!.isEmpty){
                    //     return 'Article more than 50 character are Required';
                    //   }
                    //   if(!regex.hasMatch(value)){
                    //     return 'Article more than 50 character are Required';
                    //   }
                    // },
                    controller: editArticleController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // editArticleController.text = value;
                    },
                    maxLines: 99999 ,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        fillColor: kPrimaryLightColor,
                        filled: true,
                        hintText: 'Type here...',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6.0))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.done,color: Colors.white,),
          onPressed: () {
            _loginController.databaseReference.value.child(snapshotKey!).update({
              'story': editArticleController.text,
            });
            Fluttertoast.showToast(msg: 'Article Updated');
            Get.back();
          },
        ),
      ),
    );
  }
}
