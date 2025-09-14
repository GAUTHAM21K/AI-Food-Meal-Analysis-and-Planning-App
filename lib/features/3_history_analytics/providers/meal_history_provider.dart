import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/data/models/meal_analysis.dart';
import 'package:meal_master/data/providers/repository_providers.dart';

final mealHistoryProvider = FutureProvider<List<MealAnalysis>>((ref) async {
  final repository = ref.watch(mealRepositoryProvider);
  return repository.getMealHistory();
});
