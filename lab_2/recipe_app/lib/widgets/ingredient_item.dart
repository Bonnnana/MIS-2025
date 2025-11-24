import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final String ingredient;
  final String measure;

  const IngredientItem({
    super.key,
    required this.ingredient,
    required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.red.shade300,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$ingredient $measure'.trim(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

