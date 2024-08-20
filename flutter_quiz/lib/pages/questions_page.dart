import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';
import 'package:flutter_quiz/styles/colors.dart';
import 'package:flutter_quiz/widgets/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsPage extends StatefulWidget {
  //Getting the function from parent class (Quiz) to add the user selected answers
  final Function(String) addAnswer;
  const QuestionsPage({super.key, required this.addAnswer});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  //Storing the index of question
  int currentQuestionIndex = 0;

  void answerQuestion(String ans) {
    setState(() {
      //Adding the selected answer
      widget.addAnswer(ans);

      //if the 'currentQuestionIndex' is less then 6,
      // then it gonna increment that, else means we have answered all the questions
      //beacuse we have only six questions and the 'currentQuestionIndex' is started from 0,
      //so that means the last index would be 5
      if (currentQuestionIndex != 5) {
        currentQuestionIndex++; // Increments the value by 1
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Current question
    final currentQuestion = questions[currentQuestionIndex];
    return Column(
      //Center it's child vertically
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: Text(
            currentQuestion.question,
            style: GoogleFonts.aBeeZee(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //'...' this is a spread operator which gonna add all the items from the selected list to the current list
        //map is used to perform some operation on all the items in the list
        ...currentQuestion.shuffledAnswers.map((answer) {
          return Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10),
            child: SizedBox(
                width: double.infinity,
                height: 45,
                child: AnswerButton(
                  //All possible answers for the current question
                  answerText: answer,
                  //Passing the user selected answer to 'answerQuestion' to store
                  onTap: () => answerQuestion(answer),
                )),
          );
        }),
      ],
    );
  }
}
