import 'dart:io';
import 'package:meal_master/data/models/meal_analysis.dart';
import 'package:meal_master/data/services/gemini_service.dart';
import 'package:meal_master/data/services/local_storage_service.dart';

class MealRepository {
  final GeminiService _geminiService;
  final LocalStorageService _localStorageService;

  MealRepository(this._geminiService, this._localStorageService);

  Future<MealAnalysis> analyzeAndSaveMeal(File image) async {
    try {
      final analysisJson = await _geminiService.analyzeMealImage(image);
      final mealAnalysis = MealAnalysis.fromJson(analysisJson);
      await _localStorageService.saveMeal(mealAnalysis);
      return mealAnalysis;
    } catch (e) {
      // Handle or rethrow specific exceptions
      rethrow;
    }
  }

  Future<List<MealAnalysis>> getMealHistory() {
    return _localStorageService.getSavedMeals();
  }
  
  // Placeholder for meal plan generation
  Future<Map<String,dynamic>> generatePlan(String preferences) {
    return _geminiService.generateMealPlan(preferences);
  }
}
