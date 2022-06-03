import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fearless/Screens/Welcome/components/body.dart';
import 'package:fearless/constants.dart';
import 'package:fearless/controllers/login/login_controller.dart';
import 'package:fearless/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../emergency/emergency_page.dart';
import '../helpline/helpline.dart';
import '../post/add_post.dart';
import '../post/post_view.dart';
import '../profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  // Widget? menuItem(String name,
  //     IconData icon,
  //     int id,
  //     bool selected,) {
  //   return Material(
  //     color: selected ? Colors.grey[300] : Colors.transparent,
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.pop(context);
  //         setState(() {
  //           if (id == 1) {
  //             currentPage = drawerSection.home;
  //             Get.to(HomePage(), transition: Transition.fade);
  //           } else if (id == 2) {
  //             currentPage = drawerSection.profile;
  //             Get.to(Profile(), transition: Transition.fade);
  //           } else if (id == 3) {
  //             currentPage = drawerSection.emergency;
  //           }
  //         });
  //       },
  //       child: Container(
  //         height: 40,
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: Icon(
  //                   icon,
  //                   color: kPrimaryColor,
  //                   size: 16,
  //                 )),
  //             const SizedBox(width: 30),
  //             Expanded(
  //               flex: 2,
  //               child: Text(
  //                 name,
  //                 style: const TextStyle(fontSize: 16),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // var currentPage = drawerSection.home;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUserModel = UserModel();

  DatabaseReference? _databaseReference;

  // Articles? data;
  String? database;
  bool selected = false;
  LoginController _loginController = Get.put(LoginController());


  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.ref().child('articles');
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUserModel = UserModel.fromMap(value.data());
      _loginController.textEditingControllerFirstName.value.text =
      loggedInUserModel.firstName!;
      _loginController.textEditingControllerSecondName.value.text =
      loggedInUserModel.secondName!;
      _loginController.textEditingControllerEmail.value.text =
      loggedInUserModel.email!;

      setState(() {});
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController?.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  // Future<dynamic> getData() async{
  //   _databaseReference = FirebaseDatabase.instance.ref();
  //   return await _databaseReference.child('fearless').get();
  // }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  AnimationController? _animationController;
  Animation? _animation;
  final storage = const FlutterSecureStorage();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   // backgroundColor: kPrimaryLightColor,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //       child: Column(
      //         children: [
      //           const SizedBox(
      //             height: 200,
      //           ),
      //           menuItem(
      //             'Home',
      //             Icons.home,
      //             1,
      //             currentPage == drawerSection.home ? true : false,
      //           )!,
      //           menuItem(
      //             'Profile',
      //             Icons.person,
      //             2,
      //             currentPage == drawerSection.profile ? true : false,
      //           )!,
      //           menuItem(
      //             'Emergency',
      //             Icons.help,
      //             3,
      //             currentPage == drawerSection.emergency ? true : false,
      //           )!,
      //           Material(
      //             color: selected ? Colors.grey[300] : Colors.transparent,
      //             child: InkWell(
      //               onTap: () async {
      //                 Navigator.pop(context);
      //                 FirebaseAuth.instance.signOut();
      //                 await storage.delete(key: 'uid');
      //                 Get.off(WelcomeScreen());
      //               },
      //               child: Container(
      //                 height: 40,
      //                 child: Row(
      //                   children: const [
      //                     Expanded(
      //                         child: Icon(
      //                           Icons.logout,
      //                           color: kPrimaryColor,
      //                           size: 16,
      //                         )),
      //                     SizedBox(width: 30),
      //                     Expanded(
      //                       flex: 2,
      //                       child: Text(
      //                         'Logout',
      //                         style: TextStyle(fontSize: 16),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Fearless'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(130, 211, 128, 212),
                        blurRadius: _animation?.value,
                        spreadRadius: _animation?.value)
                  ]),
              child: InkWell(
                onTap: () {
                  Get.to(Emergency());
                },
                child: const Center(
                    child: Text(
                      'Emergency',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: _databaseReference!,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  animation, index) {
                return InkWell(
                  onTap: () {
                    Get.to(PostView(
                      firstName: (snapshot.value as dynamic)['firstname'],
                      date: (snapshot.value as dynamic)['date'],
                      story: (snapshot.value as dynamic)['story'],
                    ));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text((snapshot.value as dynamic)['firstname'] ??
                            '', style: TextStyle(
                            fontSize: 16, color: Colors.black
                        ),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((snapshot.value as dynamic)['story'] ?? '',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]
                              ),),
                            Text((snapshot.value as dynamic)['date'],
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[400]
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                // Text((snapshot.value as dynamic)['story'])
              },
            ),
          )
          // Expanded(
          //   child: FutureBuilder<dynamic>(
          //       future: getData(),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasError) {
          //           return Text("Something went wrong");
          //         }
          //         else if (snapshot.hasData) {
          //           print('snapshot ${snapshot}');
          //           return Text("Document does not exist");
          //         }
          //         else{
          //           // Map<String, dynamic> data =
          //           //     snapshot.data! as Map<String, dynamic>;
          //           print('data $snapshot}');
          //           return ListView.builder(
          //               physics: AlwaysScrollableScrollPhysics(),
          //               shrinkWrap: true,
          //               itemCount: 5,
          //               itemBuilder: (context, index) {
          //                 return InkWell(
          //                   onTap: () {
          //                     // Get.to(Articles(
          //                     //   name: articles[index]['name'],
          //                     //   article: articles[index]['article'],
          //                     //   date: articles[index]['date'],
          //                     // ));
          //                   },
          //                   child: Card(
          //                     elevation: 5,
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(10.0),
          //                       child: Container(
          //                         child: Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               '',
          //                               style: const TextStyle(
          //                                   fontSize: 14, color: Colors.black),
          //                             ),
          //                             Text(
          //                               '',
          //                               style: TextStyle(
          //                                   fontSize: 12,
          //                                   color: Colors.grey[500]),
          //                             ),
          //                             Text(
          //                               '',
          //                               maxLines: 1,
          //                               style: const TextStyle(
          //                                   fontSize: 14, color: Colors.black),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               });
          //         }
          //       }),
          // )
        ],
      ),

    );
  }
}

enum drawerSection { home, emergency, logout, profile }
