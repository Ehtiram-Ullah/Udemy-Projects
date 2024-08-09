import 'package:flutter/material.dart';

//[Not used] , Custom widget for showing text on the screen
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
