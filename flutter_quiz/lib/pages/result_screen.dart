import 'package:flutter/material.dart';
import 'package:flutter_quiz/data/questions.dart';
import 'package:flutter_quiz/pages/result_screen_components/final_result.dart';

class ResultScreen extends StatelessWidget {
  //Getting the answers from parent class
  final List<String> answers;

  //Getting the 'restart' function from the parent class which is 'Quiz'
  final VoidCallback restartFunc;
  const ResultScreen(
      {super.key, required this.answers, required this.restartFunc});

  //Summary of each answer
  // List<Map<String, Object>> getSummaryData() {
  //   List<Map<String, Object>> summary = [];
  //   for (int i = 0; i < answers.length; i++) {
  //     summary.add({
  //       'question_index': i,
  //       'question': questions[i].question,
  //       'answer': questions[i].answers[0],
  //       'user_answer': answers[i],
  //     });
  //   }
  //   return summary;
  // }

  //We can also do like this, (we are using getter in this, which means we are treating the 'summaryData' as a method)
  //'get' is used to treat a method as a variable in a class
  List<Map<String, Object>> get summaryData {
    List<Map<String, Object>> summary = [];
    for (int i = 0; i < answers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].question,
        'answer': questions[i].answers[0],
        'user_answer': answers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    //Total nubmer of questions
    final totalQuestions = questions.length;

    //Correct answers
    final correctAnswers = summaryData.where(
      (element) {
        return element['user_answer'] == element['answer'];
      },
    ).length;
    return FinalResult(
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
        summaryData: summaryData,
        restartFunc: restartFunc);
  }
}
