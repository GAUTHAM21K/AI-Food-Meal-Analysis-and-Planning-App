import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/common/widgets/error_display.dart';
import 'package:meal_master/common/widgets/loading_indicator.dart';
import 'package:meal_master/features/1_meal_analysis/providers/meal_analysis_provider.dart';
import 'package:meal_master/features/1_meal_analysis/widgets/analysis_result_card.dart';
import 'package:meal_master/features/1_meal_analysis/widgets/meal_capture_button.dart';

class MealAnalysisScreen extends ConsumerWidget {
  const MealAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealAnalysisProvider);
    final notifier = ref.read(mealAnalysisProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analyze a Meal"),
        actions: [
          if (state.status != MealAnalysisStatus.initial && state.status != MealAnalysisStatus.loading)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => notifier.reset(),
            )
        ],
      ),
      body: Center(
        child: switch (state.status) {
          MealAnalysisStatus.initial => const MealCaptureView(),
          MealAnalysisStatus.loading => const LoadingIndicator(),
          MealAnalysisStatus.success => AnalysisResultCard(analysis: state.analysis!),
          MealAnalysisStatus.error => ErrorDisplay(
              message: state.errorMessage!,
              onRetry: () => notifier.reset(),
            ),
          // FIX: Add a default wildcard case to ensure the switch is exhaustive.
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class MealCaptureView extends ConsumerWidget {
  const MealCaptureView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(mealAnalysisProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.food_bank_outlined, size: 100, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          const Text(
            "Take a photo of your meal to get a detailed nutritional analysis.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 48),
          MealCaptureButton(
            icon: Icons.camera_alt,
            label: "Use Camera",
            onPressed: () => notifier.analyzeMealFromCamera(),
          ),
          const SizedBox(height: 16),
          MealCaptureButton(
            icon: Icons.photo_library,
            label: "From Gallery",
            onPressed: () => notifier.analyzeMealFromGallery(),
          ),
        ],
      ),
    );
  }
}