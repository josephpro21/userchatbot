import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ButtonWidget({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 24),
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          shadowColor: Colors.grey,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.blue, width: 2))),
      child: Text(text),
    );
  }
}
