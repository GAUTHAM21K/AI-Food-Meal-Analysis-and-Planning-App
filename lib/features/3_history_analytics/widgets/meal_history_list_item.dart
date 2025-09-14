import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_master/data/models/meal_analysis.dart';

class MealHistoryListItem extends StatelessWidget {
  final MealAnalysis meal;
  const MealHistoryListItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(DateFormat.yMMMd().add_jm().format(meal.date)),
        trailing: Text(
          "${meal.nutrition.calories} kcal",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          // You could navigate to a detail screen here
        },
      ),
    );
  }
}