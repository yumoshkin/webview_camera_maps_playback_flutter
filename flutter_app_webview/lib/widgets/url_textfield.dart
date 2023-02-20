import 'package:flutter/material.dart';

class UrlTextField extends StatelessWidget {
  const UrlTextField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFE0E0E0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
