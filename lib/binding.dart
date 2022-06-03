import 'package:fearless/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}