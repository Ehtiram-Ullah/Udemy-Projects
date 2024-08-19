import 'package:flutter/material.dart';
import 'package:flutter_quiz/pages/question_summary.dart';
import 'package:flutter_quiz/styles/colors.dart';

class FinalResult extends StatelessWidget {
  const FinalResult({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.summaryData,
    required this.restartFunc,
  });

  final int correctAnswers;
  final int totalQuestions;
  final List<Map<String, Object>> summaryData;
  final VoidCallback restartFunc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $correctAnswers out of $totalQuestions questions correctly!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: textColor),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summary: summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
                onPressed: restartFunc,
                style: TextButton.styleFrom(foregroundColor: textColor),
                icon: const Icon(Icons.refresh),
                label: const Text("Restart Quiz!"))
          ],
        ),
      ),
    );
  }
}
