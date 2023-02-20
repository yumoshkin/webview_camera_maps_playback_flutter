import 'package:flutter/material.dart';

import 'package:flutter_app_video/services/slider_service.dart';

class TimeLabelBar extends StatelessWidget {
  const TimeLabelBar({Key? key, required this.sliderService}) : super(key: key);
  final SliderService sliderService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 16,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sliderService.currentPositionLabel(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sliderService.durationLabel(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
