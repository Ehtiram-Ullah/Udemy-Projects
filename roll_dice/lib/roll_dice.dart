import 'package:flutter/material.dart';

import 'dart:math';

final randomizer = Random();

class RollDice extends StatefulWidget {
  const RollDice({super.key});

  @override
  State<RollDice> createState() => _RollDice();
}

class _RollDice extends State<RollDice> {
  int currentDice = 2;

  void onCallBack() {
    currentDice = randomizer.nextInt(6) + 1;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/dice-$currentDice.png",
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: onCallBack,
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 28)),
          child: const Text(
            "Roll dice",
          ),
        )
      ],
    );
  }
}
