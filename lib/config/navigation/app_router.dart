import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_master/data/models/meal_analysis.dart';
import 'package:meal_master/features/3_history_analytics/screens/meal_detail_screen.dart';
import 'package:meal_master/features/main_navigation/screens/main_navigation_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainNavigationScaffold(),
      ),

      // ADD THIS NEW ROUTE
      GoRoute(
        path: '/meal-detail',
        name: 'mealDetail', // Optional: naming routes is a good practice
        builder: (context, state) {
          // Extract the MealAnalysis object passed as an extra parameter
          final meal = state.extra as MealAnalysis;
          return MealDetailScreen(meal: meal);
        },
      ),
    ],
  );
});