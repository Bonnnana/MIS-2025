import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../utils/time.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final dateStr = formatDate(exam.dateTime);
    final timeStr = formatTime(exam.dateTime);
    final now = DateTime.now();
    final isFuture = exam.dateTime.isAfter(now);
    final redShade = const Color(0xB59A2236);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: exam);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isFuture ? redShade : Colors.grey.shade300,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      exam.subjectName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isFuture ? redShade : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  isFuture
                      ? const SizedBox.shrink()
                      : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Поминат',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: isFuture ? redShade : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    dateStr,
                    style: TextStyle(
                      fontSize: 14,
                      color: isFuture ? const Color(0xFF8B6F47) : Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.access_time,
                    size: 18,
                    color: isFuture ? redShade : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    timeStr,
                    style: TextStyle(
                      fontSize: 14,
                      color: isFuture ? const Color(0xFF8B6F47) : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: isFuture ? redShade : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      exam.rooms.join(', '),
                      style: TextStyle(
                        fontSize: 14,
                        color: isFuture ? const Color(0xFF8B6F47) : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
