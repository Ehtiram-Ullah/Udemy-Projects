import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';
import 'package:flutter_quiz/pages/questions_page.dart';
import 'package:flutter_quiz/pages/result_screen.dart';
import 'package:flutter_quiz/pages/starting_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //This will store the user selected answers
  List<String> selectedAnswers = [];

  //For adding answers to the list selectedAnswers
  void addAnswer(String ans) {
    //Adding the selected answer to the list
    selectedAnswers.add(ans);

    //If the length of selectedAnswers will be equal to the
    //length of questions, that means the user have answered
    //all the questions, and now it gonna
    //show the result screen
    if (selectedAnswers.length == questions.length) {
      //using 'setState' to update the UI when data changes
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    //Emptying the 'selectedAnswers' to store the new answers
    selectedAnswers = [];

    //Updating the UI
    setState(() {
      activeScreen = 'start-screen';
    });
  }

  String activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 79, 5, 128),
                Color.fromARGB(255, 64, 6, 139),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              //If the 'activeScreen' equals to 'start-screen' then show StartingPage and so on
              child: activeScreen == 'start-screen'
                  ? StartingPage(
                      func: switchScreen,
                    )
                  : activeScreen == 'result-screen'
                      ? ResultScreen(
                          answers: selectedAnswers,
                          restartFunc: restartQuiz,
                        )
                      : QuestionsPage(
                          addAnswer: addAnswer,
                        ))),
    );
  }
}
