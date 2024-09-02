import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    //$ platformBrightness
    //We can use MediaQuery class combined with 'off' context to get some information about the environment in which you app is running.
    // in here we are using platformBrightness to check whether the user is using dark or light mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),

        // $ FractionallySizedBox
        //FractionallySizedBox does not take a fixed height in pixels,
        //but a height factor instead, which simply is a number between
        //zero and one (one means that it takes 100% of the available height and vice versa).
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
