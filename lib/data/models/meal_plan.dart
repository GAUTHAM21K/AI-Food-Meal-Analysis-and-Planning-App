class MealPlan {
  final int dailyCaloriesTarget;
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;
  final Meal snacks;

  MealPlan({
    required this.dailyCaloriesTarget,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      dailyCaloriesTarget: json['daily_calories_target'] ?? 2000,
      breakfast: Meal.fromJson(json['meals']?['breakfast'] ?? {}),
      lunch: Meal.fromJson(json['meals']?['lunch'] ?? {}),
      dinner: Meal.fromJson(json['meals']?['dinner'] ?? {}),
      snacks: Meal.fromJson(json['meals']?['snacks'] ?? {}),
    );
  }

  int get totalCalories => breakfast.calories + lunch.calories + dinner.calories + snacks.calories;
}

class Meal {
  final String name;
  final int calories;

  Meal({required this.name, required this.calories});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'] ?? 'N/A',
      calories: json['calories'] ?? 0,
    );
  }
}