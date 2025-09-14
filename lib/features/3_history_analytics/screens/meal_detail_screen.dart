import 'package:flutter/material.dart';
import 'package:meal_master/data/models/meal_analysis.dart';
import 'package:meal_master/features/1_meal_analysis/widgets/analysis_result_card.dart';

class MealDetailScreen extends StatelessWidget {
  final MealAnalysis meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      // We can reuse the result card from the first feature!
      body: AnalysisResultCard(analysis: meal),
    );
  }
}