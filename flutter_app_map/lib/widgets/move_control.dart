import 'package:flutter/material.dart';

class MoveControl extends StatelessWidget {
  const MoveControl({
    Key? key,
    required this.moveToLocation,
    required this.moveTo,
  }) : super(key: key);
  final void Function() moveToLocation;
  final void Function(String direction) moveTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => moveTo('north'),
            icon: const Icon(Icons.north),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => moveTo('west'),
                icon: const Icon(Icons.west),
              ),
              IconButton(
                onPressed: moveToLocation,
                icon: const Icon(Icons.my_location),
              ),
              IconButton(
                onPressed: () => moveTo('east'),
                icon: const Icon(Icons.east),
              ),
            ],
          ),
          IconButton(
            onPressed: () => moveTo('south'),
            icon: const Icon(Icons.south),
          ),
        ],
      ),
    );
  }
}
