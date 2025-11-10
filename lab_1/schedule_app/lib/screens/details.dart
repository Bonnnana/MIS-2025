import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/details_card.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;
    final isFuture = exam.dateTime.isAfter(DateTime.now());
    final redShade = const Color(0xB59A2236);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Детали за предметот',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: isFuture ? redShade : Colors.grey.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ExamDetailsCard(exam: exam),
        ),
      ),
    );
  }
}
