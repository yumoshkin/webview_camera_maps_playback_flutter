import 'dart:math';

class SliderService {
  var _videoDuration = Duration.zero;
  var _videoPosition = Duration.zero;
  final _maxSliderPosition = 100.0;

  set videoDuration(Duration videoDuration) {
    _videoDuration = videoDuration;
  }

  double get maxSliderPosition => _maxSliderPosition;

  double sliderPosition(Duration videoPosition) {
    _videoPosition = videoPosition;

    return min(
        _maxSliderPosition,
        _maxSliderPosition *
            _videoPosition.inMilliseconds.ceilToDouble() /
            max(1, _videoDuration.inMilliseconds.ceilToDouble()));
  }

  String twoDigits(int number) => number.toString().padLeft(2, '0');

  String durationLabel() {
    String twoDigitMinutes = twoDigits(_videoDuration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_videoDuration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  String currentPositionLabel() {
    String twoDigitMinutes = twoDigits(_videoPosition.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_videoPosition.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  int backTenSec() {
    return max(
      0,
      _videoPosition.inMilliseconds - 10000,
    );
  }

  int forwardTenSec() {
    return min(
      _videoDuration.inMilliseconds,
      _videoPosition.inMilliseconds + 10000,
    );
  }

  int videoPosition(double sliderPosition) {
    return _videoDuration.inMilliseconds * sliderPosition ~/ _maxSliderPosition;
  }
}
