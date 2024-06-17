import 'package:flutter/material.dart';
import '/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.question, required this.indexAction, required this.totalQuestions});

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Questão ${indexAction + 1}/$totalQuestions:\n\n$question',
        style: const TextStyle(
          fontSize: 18.0,
          color: fontcolor,
          fontFamily: 'upheavtt',
        ),
      ),
    );
  }
}
