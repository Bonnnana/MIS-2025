import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isFuture;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isFuture,
  });

  @override
  Widget build(BuildContext context) {
    final redShade = const Color(0xB59A2236);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isFuture ? redShade : Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isFuture ? redShade : Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isFuture ? redShade : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
