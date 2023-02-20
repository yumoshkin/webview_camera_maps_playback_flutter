import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app_camera/screens/home_screen.dart';
import 'package:flutter_app_camera/state/camera_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CameraState>(
      create: (_) => CameraState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
