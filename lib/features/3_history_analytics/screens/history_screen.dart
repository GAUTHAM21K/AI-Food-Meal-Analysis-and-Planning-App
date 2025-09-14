import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import go_router
import 'package:meal_master/common/widgets/error_display.dart';
import 'package:meal_master/features/3_history_analytics/providers/meal_history_provider.dart';
import 'package:meal_master/features/3_history_analytics/widgets/meal_history_list_item.dart'; // Assuming you have this widget

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(mealHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History & Analytics"),
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => ErrorDisplay(
          message: "Could not load history.",
          onRetry: () => ref.refresh(mealHistoryProvider),
        ),
        data: (meals) {
          if (meals.isEmpty) {
            return const Center(
              child: Text("No meals analyzed yet."),
            );
          }
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(meal.name),
                  subtitle: Text("${meal.nutrition.calories} kcal"),
                  trailing: const Icon(Icons.chevron_right),
                  // UPDATE THE ONTAP FUNCTION
                  onTap: () {
                    // Navigate to the detail screen, passing the meal object
                    context.push('/meal-detail', extra: meal);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}