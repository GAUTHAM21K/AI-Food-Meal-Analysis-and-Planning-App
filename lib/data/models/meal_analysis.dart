// import 'dart:convert';

class MealAnalysis {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final Nutrition nutrition;
  final DateTime date;

  MealAnalysis({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.nutrition,
    required this.date,
  });

  factory MealAnalysis.fromJson(Map<String, dynamic> json) {
    return MealAnalysis(
      id: DateTime.now().toIso8601String(), // Generate a unique ID
      name: json['name'] ?? 'Unknown Meal',
      description: json['description'] ?? 'No description available.',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      nutrition: Nutrition.fromJson(json['nutrition'] ?? {}),
      date: DateTime.now(),
    );
  }
}

class Nutrition {
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;

  Nutrition({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      calories: (json['calories'] ?? 0).toInt(),
      protein: (json['protein_g'] ?? 0.0).toDouble(),
      carbs: (json['carbs_g'] ?? 0.0).toDouble(),
      fat: (json['fat_g'] ?? 0.0).toDouble(),
      fiber: (json['fiber_g'] ?? 0.0).toDouble(),
    );
  }
}