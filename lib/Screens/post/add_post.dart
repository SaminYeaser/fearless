import 'package:fearless/controllers/login/login_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final TextEditingController _articleController = TextEditingController();
  LoginController _loginController = Get.find();



  // setData() async{
  //   await ref.child('fearless').set({
  //     "firstname": "John",
  //     "lastname": 'samin',
  //     "article": "asdhashjdgasdjhgasjhdgajshdgajshdgas"
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          ref.child('articles')
              .push()
              .set({
            'firstname': _loginController.textEditingControllerFirstName.value.text,
            'secondname':_loginController.textEditingControllerSecondName.value.text,
            'story': _articleController.text,
            'date': DateFormat.yMMMd().format(DateTime.now())
              }).asStream();
          _articleController.clear();
        },
        backgroundColor: kPrimaryColor,
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Fearless'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value){
                      RegExp regex =  RegExp(r'^.{50,}$');
                      if(value!.isEmpty){
                        return 'Article more than 50 character are Required';
                      }
                      if(!regex.hasMatch(value)){
                        return 'Article more than 50 character are Required';
                      }
                    },
                    controller: _articleController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
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
    );
  }
}
