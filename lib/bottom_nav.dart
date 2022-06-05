import 'package:fearless/controllers/login/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Screens/Welcome/components/body.dart';
import 'Screens/emergency/emergency_page.dart';
import 'Screens/helpline/helpline.dart';
import 'Screens/home/home_page.dart';
import 'Screens/post/add_post.dart';
import 'Screens/profile/profile.dart';
import 'constants.dart';
import 'package:get/get.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  final List<Widget> screens = [
    HomePage(),
    Profile(),
    Emergency(),
    // HelpLine()
  ];

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  int currentTab = 0;
  final storage = const FlutterSecureStorage();
  LoginController _loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: _pageStorageBucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddPost());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.home,color: currentTab == 0 ? kPrimaryColor : Colors.grey,),
                        Text('Home',style: TextStyle(
                            color: currentTab == 0 ? kPrimaryColor : Colors.grey,fontSize: 12
                        ),)
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.person,color: currentTab == 1 ? kPrimaryColor : Colors.grey,),
                        Text('Profile',style: TextStyle(
                            color: currentTab == 1 ? kPrimaryColor : Colors.grey,fontSize: 12
                        ),)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Emergency();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.help,color: currentTab == 3 ? kPrimaryColor : Colors.grey,),
                        Text('Emergency',style: TextStyle(
                            color: currentTab == 3 ? kPrimaryColor : Colors.grey,
                          fontSize: 12
                        ),)
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        // currentScreen = HelpLine();
                        currentTab = 4;
                      });
                      Get.defaultDialog(
                        middleText: '',
                        title: 'Do you want to Logout?',
                        cancel: TextButton(
                          onPressed: (){
                            Get.back();
                          }, child: Text('cancel'),
                        ),
                        confirm: TextButton(
                          onPressed: () async{
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut();
                            await storage.delete(key: 'uid');
                            _loginController.image.value = null;
                            _loginController.textEditingControllerPassword.value.clear();
                            Get.off(WelcomeScreen());
                          }, child: Text('Yes'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.logout,color: currentTab == 4 ? kPrimaryColor : Colors.grey,),
                        Text('Logout',style: TextStyle(
                            color: currentTab == 4 ? kPrimaryColor : Colors.grey,fontSize: 12
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
