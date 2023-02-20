import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_app_video/services/slider_service.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key? key,
    required this.controller,
    required this.sliderService,
  }) : super(key: key);
  final VideoPlayerController controller;
  final SliderService sliderService;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              controller.seekTo(
                Duration(
                  milliseconds: sliderService.backTenSec(),
                ),
              );
            },
            icon: const Icon(Icons.replay_10, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            icon: controller.value.isPlaying
                ? const Icon(Icons.pause, size: 32, color: Colors.white)
                : const Icon(Icons.play_arrow, size: 32, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              controller.seekTo(
                Duration(
                  milliseconds: sliderService.forwardTenSec(),
                ),
              );
            },
            icon: const Icon(Icons.forward_10, size: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
