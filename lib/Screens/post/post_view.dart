import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class PostView extends StatelessWidget {
  String? firstName;
  String? date;
  String? story;
  PostView({this.firstName, this.date,this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Post View',style: TextStyle(color: Colors.white),),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                  Text(firstName!,style: TextStyle(
                    color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 10,),
                Text(date!,style: TextStyle(
                    color: Colors.grey[500],fontSize: 12, fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Text(story!,style: TextStyle(
                    color: Colors.black38,fontSize: 14, fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
