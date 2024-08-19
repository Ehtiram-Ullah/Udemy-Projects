import 'package:flutter/material.dart';

//Custom button for the answers
class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.answerText, required this.onTap});
  //The actual answer
  final String answerText;

  //Storing the function here,
  //this gonna ensure that what gonna happen when the user click this button
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //Passing the 'onTap' function (which we got from the parrent class) to 'onPressed'
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        //Button color
        backgroundColor: const Color.fromARGB(255, 5, 4, 70),
        //Text color
        foregroundColor: Colors.white,
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
