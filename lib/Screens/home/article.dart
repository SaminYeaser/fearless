import 'package:flutter/material.dart';

import '../../constants.dart';

class Articles extends StatelessWidget {
  String? name;
  String? date;
  String? article;
  Articles({this.name, this.article, this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Article'),
        titleSpacing: 0,
        // actions: [
        //   IconButton(onPressed: () async{
        //     FirebaseAuth.instance.signOut();
        //     await storage.delete(key: 'uid');
        //     Get.off(WelcomeScreen());
        //   }, icon: const Icon(Icons.logout))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            children: [
              Text(name!,style: const TextStyle(
                  fontSize: 14, color: Colors.black
              ),),
              SizedBox(height: 10,),
              Text(date!,style:  TextStyle(
                  fontSize: 14, color: Colors.grey[700]
              ),),
              SizedBox(height: 20,),
              Text(article!,style: const TextStyle(
                  fontSize: 18, color: Colors.black
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
