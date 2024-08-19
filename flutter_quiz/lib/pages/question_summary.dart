import 'package:flutter/material.dart';
import 'package:flutter_quiz/pages/result_screen_components/question_numbers.dart';
import 'package:flutter_quiz/pages/result_screen_components/questions_overview.dart';

class QuestionSummary extends StatelessWidget {
  //Result
  final List<Map<String, Object>> summary;
  const QuestionSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: summary.map((data) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Add numbers
              QuestionNumbers(data: data),
              const SizedBox(
                width: 20,
              ),
              //Showing the question, user answer and expected answer
              QuestionsOverview(
                data: data,
              )
            ],
          );
        }).toList()), //Converting it to list beacuse the '.map' method returns 'Iterable' and the column needs 'List'
      ),
    );
  }
}
