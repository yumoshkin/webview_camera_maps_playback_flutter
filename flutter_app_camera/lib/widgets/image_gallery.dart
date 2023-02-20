import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_camera/state/camera_state.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (context, state, child) => ListView.separated(
        itemCount: state.imagePaths.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1, thickness: 1, color: Colors.grey),
        itemBuilder: (BuildContext context, int index) => SizedBox(
          height: 170,
          child: Image.file(
            File(state.imagePaths[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
