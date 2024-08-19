import 'package:flutter/material.dart';
import 'package:flutter_quiz/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingPage extends StatelessWidget {
  //stroing the function
  final VoidCallback func;

  const StartingPage(
      {super.key,
      required this.func}); //Getting the function from the parent class in which this class will be instantiated

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Different methods for chaning the opecity

          //Opacity can also be changed by using this approach,
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset(
          //     "assets/images/quiz-logo.png",
          //     width: 300,
          //   ),
          // ),

          //Also this approach
          // Image.asset(
          //   "assets/images/quiz-logo.png",
          //   width: 300,
          //   color: const Color.fromARGB(90, 255, 255, 255),
          // ),

          Image.asset(
            "assets/images/quiz-logo.png",
            width: 300,
            opacity: const AlwaysStoppedAnimation(0.6),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Learn Flutter the fun way!",
              //Using font from googleFonts
              style: GoogleFonts.aBeeZee(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ),

          //The '.icon' is used for adding icon to the button
          ElevatedButton.icon(
            onPressed: func,
            style: ElevatedButton.styleFrom(
              foregroundColor: textColor,

              //Removing the roundess from the button borders
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              backgroundColor: backgroundColor,

              //Color for the shadow
              shadowColor: Colors.black,

              //Giving 3D look by rising it up from the surface
              elevation: 2,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text(
              "Start Quiz",
            ),
          )
        ],
      ),
    );
  }
}
