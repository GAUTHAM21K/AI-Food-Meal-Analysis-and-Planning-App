import 'package:flutter/material.dart';

class NutrientDisplayChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const NutrientDisplayChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color),
      label: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}