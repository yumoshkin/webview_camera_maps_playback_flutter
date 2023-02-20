import 'package:flutter/material.dart';

class ZoomControl extends StatelessWidget {
  const ZoomControl({
    Key? key,
    required this.zoomIn,
    required this.zoomOut,
  }) : super(key: key);
  final void Function() zoomIn;
  final void Function() zoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: zoomIn,
            icon: const Icon(Icons.add, size: 32),
          ),
        ),
        const SizedBox(height: 44),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: zoomOut,
            icon: const Icon(Icons.remove, size: 32),
          ),
        ),
      ],
    );
  }
}
