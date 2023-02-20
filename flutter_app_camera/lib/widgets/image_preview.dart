import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_camera/state/camera_state.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({Key? key}) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  XFile? lastImage;

  @override
  void initState() {
    super.initState();
    unawaited(initCamera());
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller!.initialize();
    setState(() {});
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void takePicture() {
    controller?.takePicture().then((lastImage) {
      context.read<CameraState>().addImagePath(lastImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller?.value.isInitialized == true
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(controller!),
            )
          : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
