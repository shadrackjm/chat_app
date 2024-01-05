import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String textHint;
  final bool ObsecureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.textHint,
    required this.ObsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: controller,
            obscureText: ObsecureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: textHint,
            ),
          ),
        ),
      ),
    );
  }
}
