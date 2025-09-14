import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/data/models/meal_plan.dart';
import 'package:meal_master/data/providers/repository_providers.dart';

enum MealPlanStatus { initial, loading, success, error }

class MealPlanState {
  final MealPlanStatus status;
  final MealPlan? plan;
  final String? errorMessage;

  MealPlanState({
    this.status = MealPlanStatus.initial,
    this.plan,
    this.errorMessage,
  });

  MealPlanState copyWith({
    MealPlanStatus? status,
    MealPlan? plan,
    String? errorMessage,
  }) {
    return MealPlanState(
      status: status ?? this.status,
      plan: plan ?? this.plan,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MealPlanNotifier extends StateNotifier<MealPlanState> {
  final Ref _ref;

  MealPlanNotifier(this._ref) : super(MealPlanState());

  Future<void> generatePlan({
    required String preferences,
    required String restrictions,
    required String calories,
  }) async {
    state = state.copyWith(status: MealPlanStatus.loading);
    try {
      final repository = _ref.read(mealRepositoryProvider);
      final prompt = "Preferences: $preferences. Restrictions: $restrictions. Target calories: $calories.";
      final resultJson = await repository.generatePlan(prompt);
      final plan = MealPlan.fromJson(resultJson);
      state = state.copyWith(status: MealPlanStatus.success, plan: plan);
    } catch (e) {
      state = state.copyWith(
        status: MealPlanStatus.error,
        errorMessage: "Could not generate a meal plan. Please try again.",
      );
    }
  }
  
  void reset() {
    state = MealPlanState();
  }
}

final mealPlanProvider = StateNotifierProvider<MealPlanNotifier, MealPlanState>((ref) {
  return MealPlanNotifier(ref);
});