import 'package:flutter/material.dart';

import 'package:flutter_app_camera/widgets/image_gallery.dart';
import 'package:flutter_app_camera/widgets/image_preview.dart';

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        ImagePreview(),
        ImageGallery(),
      ],
    );
  }
}
