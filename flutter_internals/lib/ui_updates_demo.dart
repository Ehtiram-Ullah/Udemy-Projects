import 'package:flutter/material.dart';
import 'package:flutter_internals/state_widget.dart';

class UIUpdatesDemo extends StatelessWidget {
  const UIUpdatesDemo({super.key});
  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo BUILD called');
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            StateWidget()
          ],
        ),
      ),
    );
  }
}
