import 'package:flutter/material.dart';
import 'package:meal_master/data/models/meal_plan.dart';

class GeneratedPlanView extends StatelessWidget {
  final MealPlan plan;
  const GeneratedPlanView({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Your Daily Plan", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          _TotalCaloriesCard(plan: plan),
          const SizedBox(height: 16),
          _MealCard(mealType: "Breakfast", meal: plan.breakfast, icon: Icons.free_breakfast),
          _MealCard(mealType: "Lunch", meal: plan.lunch, icon: Icons.lunch_dining),
          _MealCard(mealType: "Dinner", meal: plan.dinner, icon: Icons.dinner_dining),
          _MealCard(mealType: "Snacks", meal: plan.snacks, icon: Icons.bakery_dining),
        ],
      ),
    );
  }
}

class _TotalCaloriesCard extends StatelessWidget {
  const _TotalCaloriesCard({required this.plan});
  final MealPlan plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Calories", style: Theme.of(context).textTheme.titleMedium),
                Text("Target: ${plan.dailyCaloriesTarget} kcal", style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Text("${plan.totalCalories} kcal",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final String mealType;
  final Meal meal;
  final IconData icon;

  const _MealCard({required this.mealType, required this.meal, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(mealType, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(meal.name),
        trailing: Text("${meal.calories} kcal"),
      ),
    );
  }
}