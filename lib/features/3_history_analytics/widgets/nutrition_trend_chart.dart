import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_master/data/models/meal_analysis.dart';

class NutritionTrendChart extends StatelessWidget {
  final List<MealAnalysis> meals;
  const NutritionTrendChart({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final dailyTotals = _calculateDailyTotals();

    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: (dailyTotals.values.reduce((a, b) => a > b ? a : b) * 1.2).toDouble(), // Add 20% padding to max Y
              barGroups: dailyTotals.entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key.weekday,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: Theme.of(context).colorScheme.primary,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final day = _getWeekday(value.toInt());
                      return SideTitleWidget(axisSide: meta.axisSide, child: Text(day));
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  String _getWeekday(int value) {
    switch (value) {
      case 1: return 'M';
      case 2: return 'T';
      case 3: return 'W';
      case 4: return 'T';
      case 5: return 'F';
      case 6: return 'S';
      case 7: return 'S';
      default: return '';
    }
  }

  Map<DateTime, int> _calculateDailyTotals() {
    final Map<DateTime, int> totals = {};
    final today = DateTime.now();
    final sevenDaysAgo = today.subtract(const Duration(days: 6));

    final recentMeals = meals.where((meal) => meal.date.isAfter(sevenDaysAgo));

    for (final meal in recentMeals) {
      final day = DateTime(meal.date.year, meal.date.month, meal.date.day);
      totals.update(day, (value) => value + meal.nutrition.calories, ifAbsent: () => meal.nutrition.calories);
    }
    return totals;
  }
}
