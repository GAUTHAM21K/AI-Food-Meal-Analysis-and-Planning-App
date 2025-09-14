import 'package:meal_master/data/models/meal_analysis.dart';

// Abstract class for the service
abstract class LocalStorageService {
  Future<void> saveMeal(MealAnalysis meal);
  Future<List<MealAnalysis>> getSavedMeals();
}

// Mock implementation for demonstration
class MockLocalStorageService implements LocalStorageService {
  final List<MealAnalysis> _mockDatabase = [];

  @override
  Future<void> saveMeal(MealAnalysis meal) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockDatabase.add(meal);
    print("Meal '${meal.name}' saved to mock database.");
  }

  @override
  Future<List<MealAnalysis>> getSavedMeals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("Fetched ${_mockDatabase.length} meals from mock database.");
    return List.from(_mockDatabase.reversed); // Show newest first
  }
}