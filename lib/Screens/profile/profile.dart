import 'package:fearless/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {

  LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        titleSpacing: 0,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: 100,
                ),),
                SizedBox(height: 50,),
                Text('First Name', style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold
                ),),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Your Email';
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)){
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller: _loginController.textEditingControllerFirstName.value,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    enabled: false,
                      prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),

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
                SizedBox(height: 15,),
                Text('Second Name', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold
                ),),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Your Email';
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)){
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller: _loginController.textEditingControllerSecondName.value,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),
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
                SizedBox(height: 15,),
                Text('E-Mail', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold
                ),),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please Enter Your Email';
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)){
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  controller: _loginController.textEditingControllerEmail.value,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: kPrimaryColor,),
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
                SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    splashFactory: InkSplash.splashFactory ,
                    onTap: (){
                        Get.to(EditProfile(), transition: Transition.fadeIn);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('Edit My Profile', style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
