import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageHelper{

  static Future<File?> getImageFromGallery() async {
    File _image;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return null;
    }
    // return _image;
  }
  static Future<File?> getImageFromCamera() async {
    File _image;
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        return _image;
      } else {
        print('No image selected.');
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
    // return _image;
  }
}