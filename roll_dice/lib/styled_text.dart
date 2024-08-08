import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final text;
  const StyledText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 28),
    );
  }
}
