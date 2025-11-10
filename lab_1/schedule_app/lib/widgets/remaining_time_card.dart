import 'package:flutter/material.dart';

class RemainingTimeCard extends StatelessWidget {
  final bool isFuture;
  final String remaining;

  const RemainingTimeCard({
    super.key,
    required this.isFuture,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final redShade = const Color(0xB59A2236);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFuture ? redShade : Colors.grey,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            size: 28,
            color: isFuture ? redShade : Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Преостанува',
                  style: TextStyle(
                    fontSize: 14,
                    color: isFuture ? redShade : Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  remaining,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isFuture ? redShade : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
