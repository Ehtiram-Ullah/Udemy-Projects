import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {
  const StateWidget({super.key});

  @override
  State<StateWidget> createState() {
    return _StateWidgetState();
  }
}

class _StateWidgetState extends State<StateWidget> {
  //for updating the UI
  bool _isUnderstood = false;
  @override
  Widget build(BuildContext context) {
    print("build is called from 'StateWidget'");
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _isUnderstood = false;
              });
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isUnderstood = true;
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
      if (_isUnderstood) const Text('Awesome!'),
    ]);
  }
}
