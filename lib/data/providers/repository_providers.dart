import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/data/providers/dio_provider.dart';
import 'package:meal_master/data/repositories/meal_repository.dart';
import 'package:meal_master/data/services/gemini_service.dart';
import 'package:meal_master/data/services/local_storage_service.dart';

// Provider for Gemini Service
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService(ref.watch(dioProvider));
});

// Provider for Local Storage Service
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  // Swap this out for a real implementation (e.g., Hive, Isar)
  return MockLocalStorageService();
});

// The main repository provider that the UI will interact with
final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepository(
    ref.watch(geminiServiceProvider),
    ref.watch(localStorageServiceProvider),
  );
});