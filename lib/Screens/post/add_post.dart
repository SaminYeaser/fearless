import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _articleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
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
