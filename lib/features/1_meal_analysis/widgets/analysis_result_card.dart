import 'package:flutter/material.dart';
import 'package:meal_master/common/widgets/nutrient_display_chip.dart';
import 'package:meal_master/data/models/meal_analysis.dart';

class AnalysisResultCard extends StatelessWidget {
  final MealAnalysis analysis;

  const AnalysisResultCard({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nutrition = analysis.nutrition;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(analysis.name, style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(analysis.description, style: textTheme.bodyLarge),
          const SizedBox(height: 24),
          Text("Nutritional Information", style: textTheme.titleLarge),
          const Divider(),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "${nutrition.calories} kcal",
              style: textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.center,
            children: [
              NutrientDisplayChip(label: "Protein", value: "${nutrition.protein}g", color: Colors.blue),
              NutrientDisplayChip(label: "Carbs", value: "${nutrition.carbs}g", color: Colors.orange),
              NutrientDisplayChip(label: "Fat", value: "${nutrition.fat}g", color: Colors.red),
              NutrientDisplayChip(label: "Fiber", value: "${nutrition.fiber}g", color: Colors.green),
            ],
          ),
          const SizedBox(height: 24),
          Text("Detected Ingredients", style: textTheme.titleLarge),
          const Divider(),
          const SizedBox(height: 8),
          if (analysis.ingredients.isEmpty)
            const Text("No specific ingredients detected.")
          else
            for (final ingredient in analysis.ingredients)
              ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                title: Text(ingredient),
                dense: true,
              ),
        ],
      ),
    );
  }
}