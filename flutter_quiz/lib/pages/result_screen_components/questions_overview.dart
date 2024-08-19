import 'package:flutter/material.dart';

class QuestionsOverview extends StatelessWidget {
  final Map<String, Object> data;
  const QuestionsOverview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Accessing the data
          Text(
            data['question'] as String,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data['user_answer'] as String,
            style: const TextStyle(color: Color.fromARGB(255, 183, 58, 177)),
          ),
          Text(
            data['answer'] as String,
            style: const TextStyle(color: Color.fromARGB(255, 141, 139, 228)),
          ),
        ],
      ),
    );
  }
}
