import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fearless/Screens/Welcome/components/body.dart';
import 'package:fearless/Screens/home/article.dart';
import 'package:fearless/constants.dart';
import 'package:fearless/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Map> articles = [
    {
      'name': 'Wafa Maliha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '12th May, 2022'
    },
    {
      'name': 'Inzamam Khan',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '13th May, 2022'
    },
    {
      'name': 'Tazrin Samiha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '13th June, 2022'
    },
    {
      'name': 'Bolod Khan Maliha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '30th February, 2022'
    },
    {
      'name': 'Wafa Maliha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '12th May, 2022'
    },
    {
      'name': 'Inzamam Khan',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '13th May, 2022'
    },
    {
      'name': 'Tazrin Samiha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '13th June, 2022'
    },
    {
      'name': 'Bolod Khan Maliha',
      'article':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'date': '30th February, 2022'
    }
  ];

  Widget? menuItem(
    String name,
    IconData icon,
    int id,
    bool selected,
  ) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = drawerSection.home;
            } else if (id == 2) {
              currentPage = drawerSection.profile;
            } else if (id == 3) {
              currentPage = drawerSection.emergency;
            }
          });
        },
        child: Container(
          height: 40,
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                color: kPrimaryColor,
                size: 16,
              )),
              const SizedBox(width: 30),
              Expanded(
                flex: 2,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  var currentPage = drawerSection.home;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUserModel = UserModel();
  bool selected = false;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUserModel = UserModel.fromMap(value.data());
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
      drawer: Drawer(
        // backgroundColor: kPrimaryLightColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                menuItem(
                  'Home',
                  Icons.home,
                  1,
                  currentPage == drawerSection.home ? true : false,
                )!,
                menuItem(
                  'Profile',
                  Icons.person,
                  2,
                  currentPage == drawerSection.profile ? true : false,
                )!,
                menuItem(
                  'Emergency',
                  Icons.help,
                  3,
                  currentPage == drawerSection.emergency ? true : false,
                )!,
                Material(
                  color: selected ? Colors.grey[300] : Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      FirebaseAuth.instance.signOut();
                      await storage.delete(key: 'uid');
                      Get.off(WelcomeScreen());
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        children: const [
                          Expanded(
                              child: Icon(
                            Icons.logout,
                            color: kPrimaryColor,
                            size: 16,
                          )),
                          SizedBox(width: 30),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Logout',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        // automaticallyImplyLeading: false,
        title: const Text('Fearless'),
        titleSpacing: 0,
        // actions: [
        //   IconButton(onPressed: () async{
        //     FirebaseAuth.instance.signOut();
        //     await storage.delete(key: 'uid');
        //     Get.off(WelcomeScreen());
        //   }, icon: const Icon(Icons.logout))
        // ],
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
                onTap: (){
                  Fluttertoast.showToast(msg: 'Emergency Button Coming soon');
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
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(Articles(
                        name: articles[index]['name'],
                        article: articles[index]['article'],
                        date: articles[index]['date'],
                      ));
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articles[index]['name'],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                articles[index]['date'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[500]),
                              ),
                              Text(
                                articles[index]['article'],
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Fluttertoast.showToast(msg: 'Add Post Coming soon');
        },
      ),
    );
  }
}

enum drawerSection { home, emergency, logout, profile }
