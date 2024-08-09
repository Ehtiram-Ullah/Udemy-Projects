import 'package:flutter/material.dart';
import 'package:roll_dice/roll_dice.dart';

class MyOwnGradientContainer extends StatelessWidget {
  const MyOwnGradientContainer(this.colors, {super.key});

  //Another constructor other then the main constructor
  MyOwnGradientContainer.beautiful({super.key})
      : colors = [
          const Color.fromARGB(255, 28, 5, 65),
          const Color.fromARGB(255, 43, 8, 90)
        ];
  final List<Color> colors;

  @override
  build(context) {
    return Container(
        decoration: BoxDecoration(
            //Gradient is used for using more then one color at a time
            gradient:
                LinearGradient(colors: colors, begin: Alignment.topRight)),
        child: const Center(child: RollDice()));
  }
}
