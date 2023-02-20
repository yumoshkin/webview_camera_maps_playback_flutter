import 'package:flutter/material.dart';

class CameraState with ChangeNotifier {
  List<String> imagePaths = [];

  void addImagePath(String imagePath) {
    imagePaths.add(imagePath);
    notifyListeners();
  }
}
