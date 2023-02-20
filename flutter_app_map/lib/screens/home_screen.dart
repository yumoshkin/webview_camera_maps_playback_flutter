import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:flutter_app_map/widgets/move_control.dart';
import 'package:flutter_app_map/widgets/zoom_control.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YandexMapController controller;
  static const Point _point = Point(
    latitude: 55.752517,
    longitude: 37.623133,
  );
  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 1.2,
  );
  late Point _currentPoint;
  late double _currentZoom;

  void moveToLocation() async {
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(const CameraPosition(target: _point)),
      animation: animation,
    );

    _currentPoint = Point(
      latitude: _point.latitude,
      longitude: _point.longitude,
    );
  }

  void moveTo(String direction) async {
    const offset = 0.015;
    var latitude = _currentPoint.latitude;
    var longitude = _currentPoint.longitude;

    switch (direction) {
      case 'north':
        latitude += offset;
        break;
      case 'south':
        latitude -= offset;
        break;
      case 'west':
        longitude -= offset;
        break;
      case 'east':
        longitude += offset;
        break;
    }

    _currentPoint = Point(
      latitude: latitude,
      longitude: longitude,
    );

    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPoint, zoom: _currentZoom),
      ),
      animation: animation,
    );
  }

  void zoomIn() async {
    await controller.moveCamera(CameraUpdate.zoomIn(), animation: animation);
  }

  void zoomOut() async {
    await controller.moveCamera(CameraUpdate.zoomOut(), animation: animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            logoAlignment: const MapAlignment(
                horizontal: HorizontalAlignment.left,
                vertical: VerticalAlignment.bottom),
            onMapCreated: (yandexMapController) async {
              controller = yandexMapController;
              moveToLocation();
            },
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              _currentZoom = cameraPosition.zoom;
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoveControl(moveToLocation: moveToLocation, moveTo: moveTo),
                  ZoomControl(zoomIn: zoomIn, zoomOut: zoomOut),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
