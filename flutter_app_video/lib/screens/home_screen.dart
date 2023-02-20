import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_app_video/services/slider_service.dart';
import 'package:flutter_app_video/widgets/action_bar.dart';
import 'package:flutter_app_video/widgets/time_label_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final _sliderService = SliderService();
  var _sliderPosition = 0.0;
  var _isControlVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize()
      ..then((_) {
        setState(() {
          _sliderService.videoDuration = _controller.value.duration;
        });
      });

    _controller.addListener(updateSlider);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> updateSlider() async {
    final videoPosition = await _controller.position ?? Duration.zero;
    setState(() {
      _sliderPosition = _sliderService.sliderPosition(videoPosition);
    });
  }

  void toggleControlVisible() {
    setState(() {
      _isControlVisible = !_isControlVisible;
    });
  }

  void onChangedSlider(double value) {
    _controller
        .seekTo(Duration(milliseconds: _sliderService.videoPosition(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Earth'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Content is unavailable'));
            }

            return Align(
              alignment: Alignment.topCenter,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: toggleControlVisible,
                      child: VideoPlayer(_controller),
                    ),
                    _isControlVisible
                        ? ActionBar(
                            controller: _controller,
                            sliderService: _sliderService,
                          )
                        : const SizedBox.shrink(),
                    _isControlVisible
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 84,
                              child: Slider(
                                min: 0,
                                max: _sliderService.maxSliderPosition,
                                value: _sliderPosition,
                                onChanged: onChangedSlider,
                                onChangeStart: (value) {
                                  _controller.pause();
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _isControlVisible
                        ? TimeLabelBar(sliderService: _sliderService)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
