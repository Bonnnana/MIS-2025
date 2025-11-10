import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../utils/time.dart';
import 'details_row.dart';
import 'remaining_time_card.dart';

class ExamDetailsCard extends StatelessWidget {
  final Exam exam;

  const ExamDetailsCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final dateStr = formatDate(exam.dateTime);
    final timeStr = formatTime(exam.dateTime);
    final remaining = formatRemaining(exam.dateTime);
    final isFuture = exam.dateTime.isAfter(DateTime.now());
    final redShade = const Color(0xB59A2236);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isFuture ? redShade : Colors.grey,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.subjectName.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isFuture ? redShade : Colors.grey.shade800,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),

            DetailRow(
              icon: Icons.calendar_today,
              label: 'Датум',
              value: dateStr,
              isFuture: isFuture,
            ),
            const SizedBox(height: 16),

            DetailRow(
              icon: Icons.access_time,
              label: 'Време',
              value: timeStr,
              isFuture: isFuture,
            ),
            const SizedBox(height: 16),

            DetailRow(
              icon: Icons.location_on,
              label: 'Простории',
              value: exam.rooms.join(', '),
              isFuture: isFuture,
            ),
            const SizedBox(height: 24),

            RemainingTimeCard(
              isFuture: isFuture,
              remaining: remaining,
            ),
          ],
        ),
      ),
    );
  }
}
