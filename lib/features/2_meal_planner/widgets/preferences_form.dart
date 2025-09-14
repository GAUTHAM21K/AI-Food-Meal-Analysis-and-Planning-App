import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/features/2_meal_planner/providers/meal_plan_provider.dart';

// A simple provider to hold our text controllers.
// The cleanup logic is now correctly placed inside the provider.
final _formControllersProvider = Provider.autoDispose((ref) {
  final controllers = {
    'preferences': TextEditingController(text: 'High protein'),
    'restrictions': TextEditingController(text: 'None'),
    'calories': TextEditingController(text: '2000'),
  };

  // When the provider is disposed, this function will be called to clean up the controllers.
  ref.onDispose(() {
    controllers.forEach((_, controller) => controller.dispose());
  });

  return controllers;
});

class PreferencesForm extends ConsumerWidget {
  const PreferencesForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = ref.watch(_formControllersProvider);
    final planNotifier = ref.read(mealPlanProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("AI Meal Planning", style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text("Tell us your goals, and we'll generate a personalized plan.", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          TextFormField(
            controller: controllers['preferences'],
            decoration: const InputDecoration(labelText: "Dietary Preferences", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controllers['restrictions'],
            decoration: const InputDecoration(labelText: "Allergies or Restrictions", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: controllers['calories'],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Target Daily Calories", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: const Text("Generate My Meal Plan"),
            onPressed: () {
              // Trigger the provider to start fetching the meal plan
              planNotifier.generatePlan(
                preferences: controllers['preferences']!.text,
                restrictions: controllers['restrictions']!.text,
                calories: controllers['calories']!.text,
              );
            },
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), textStyle: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}