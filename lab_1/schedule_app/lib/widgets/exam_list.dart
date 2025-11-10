import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'exam_card.dart';

class ExamList extends StatelessWidget {
  final List<Exam> exams;
  const ExamList({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    if (exams.isEmpty) {
      return const Center(
        child: Text('Нема испити'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
      itemCount: exams.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ExamCard(exam: exams[index]),
    );
  }
}
