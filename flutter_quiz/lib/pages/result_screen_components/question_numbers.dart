import 'package:flutter/material.dart';

class QuestionNumbers extends StatelessWidget {
  final Map<String, Object> data;
  const QuestionNumbers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(

          //If the user answer is correct then it gonna be blue else pink
          color: data['user_answer'] == data['answer']
              ? const Color.fromARGB(255, 116, 181, 235)
              : const Color.fromARGB(255, 223, 101, 142),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        ((data['question_index'] as int) + 1).toString(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
