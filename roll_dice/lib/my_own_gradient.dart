import 'package:flutter/material.dart';
import 'package:roll_dice/roll_dice.dart';

class MyOwnGradientContainer extends StatelessWidget {
  const MyOwnGradientContainer(this.colors, {super.key});

  MyOwnGradientContainer.beautiful({super.key})
      : colors = [Colors.black, const Color.fromARGB(255, 0, 0, 0)];
  final List<Color> colors;

  @override
  build(context) {
    return Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: colors, begin: Alignment.topRight)),
        child: const Center(child: RollDice()));
  }
}
