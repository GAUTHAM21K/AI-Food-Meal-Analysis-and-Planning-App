import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/common/widgets/error_display.dart';
import 'package:meal_master/common/widgets/loading_indicator.dart';
import 'package:meal_master/features/2_meal_planner/providers/meal_plan_provider.dart';
import 'package:meal_master/features/2_meal_planner/widgets/generated_plan_view.dart';
import 'package:meal_master/features/2_meal_planner/widgets/preferences_form.dart';

class MealPlannerScreen extends ConsumerWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealPlanProvider);
    final notifier = ref.read(mealPlanProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Planner"),
         actions: [
          // Show a refresh button only after a plan is generated or an error occurs
          if (state.status != MealPlanStatus.initial && state.status != MealPlanStatus.loading)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => notifier.reset(),
            )
        ],
      ),
      body: Center(
        // Switch the UI based on the provider's state
        child: switch (state.status) {
          MealPlanStatus.initial => const PreferencesForm(),
          MealPlanStatus.loading => const LoadingIndicator(),
          MealPlanStatus.success => GeneratedPlanView(plan: state.plan!),
          MealPlanStatus.error => ErrorDisplay(
              message: state.errorMessage!,
              onRetry: () => notifier.reset(),
            ),
          _ => const SizedBox.shrink(), // Default case
        },
      ),
    );
  }
}