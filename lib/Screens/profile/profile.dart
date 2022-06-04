import 'dart:io';

import 'package:fearless/Screens/post/edit_post.dart';
import 'package:fearless/controllers/login/login_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../components/image_helper.dart';
import '../../constants.dart';
import '../post/post_view.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginController _loginController = Get.find();

  _showPictureOptionDialogue() {
    // final AddContactsController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text("Picture option"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ImageHelper.getImageFromCamera().then((value) {
                        _loginController.image.value = value;
                        navigator?.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/icons/camera.svg', height: 30,),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //getImageFromGallery(option);
                      ImageHelper.getImageFromGallery().then((value) {
                        _loginController.image.value = value;
                        navigator?.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/icons/gallery.svg', height: 30,),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    navigator?.pop();
                  },
                )
              ],
            ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Picture option"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ImageHelper.getImageFromCamera().then((value) {
                        _loginController.image.value = value;
                        navigator?.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          SvgPicture.asset('assets/icons/camera.svg', height: 30,),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //getImageFromGallery(option);
                      ImageHelper.getImageFromGallery().then((value) {
                        _loginController.image.value = value;
                        navigator?.pop();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          SvgPicture.asset('assets/icons/gallery.svg', height: 30,),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    navigator?.pop();
                  },
                )
              ],
            ));
      }
    } catch (e) {}
  }
  Future uploadFile() async{
    if(_loginController.image.value == null) return;
    final destination = 'profile_pic/${_loginController.image.value!.path}';

    uploadImage(destination, _loginController.image.value);

  }
  uploadImage(destination, file){
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>Column(
                  children: [
                    InkWell(
                      onTap: (){
                        _showPictureOptionDialogue();
                      },
                      child: Center(
                        child: _loginController.image.value == null? SvgPicture.asset(
                          'assets/icons/profile.svg',
                          height: 100,
                        ) : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                            child: Image.file(_loginController.image.value!, height: 150,)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    _loginController.image.value == null ? Center(
                      child: Text('Upload Your Image', style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700
                      ),),
                    ) : InkWell(
                      onTap: () {
                        uploadFile();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                          child: Text('Upload', style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'First Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller:
                      _loginController.textEditingControllerFirstName.value,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      enabled: false,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      fillColor: kPrimaryLightColor,
                      filled: true,
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Second Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller:
                      _loginController.textEditingControllerSecondName.value,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      enabled: false,
                      fillColor: kPrimaryLightColor,
                      filled: true,
                      hintText: 'Second Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'E-Mail',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller: _loginController.textEditingControllerEmail.value,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      enabled: false,
                      fillColor: kPrimaryLightColor,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    splashFactory: InkSplash.splashFactory,
                    onTap: () {
                      Get.to(EditProfile(), transition: Transition.fadeIn);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'Edit My Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'My Articles',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FirebaseAnimatedList(
                  reverse: true,
                  query: _loginController.databaseReference.value,
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
                      child: (snapshot.value as dynamic)['mail'] ==
                              _loginController
                                  .textEditingControllerEmail.value.text
                          ? Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ListTile(
                                  title: Text(
                                    (snapshot.value as dynamic)['firstname'] ??
                                        '',

                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (snapshot.value as dynamic)['story'] ??
                                            '', maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600]),
                                      ),
                                      Text(
                                        (snapshot.value as dynamic)['date'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // _loginController.articleController.value.text = (snapshot.value as dynamic)['story'];
                                            Get.to(EditPost(
                                              snapshotKey: snapshot.key,
                                              story: (snapshot.value as dynamic)['story'],
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title:
                                                  'Do you want to delete the article?',
                                              middleText: '',
                                              cancel: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              confirm: TextButton(
                                                onPressed: () {
                                                  _loginController
                                                      .databaseReference.value
                                                      .child(snapshot.key!)
                                                      .remove();
                                                  Fluttertoast.showToast(msg: 'Article Deleted');
                                                  Get.back();
                                                },
                                                child: Text('Yes'),
                                              )
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    );
                    // Text((snapshot.value as dynamic)['story'])
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
