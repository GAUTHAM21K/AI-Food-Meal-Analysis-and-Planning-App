import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifier extends StateNotifier<Map<String, TextEditingController>> {
  UserProfileNotifier() : super({
    'preferences': TextEditingController(text: 'High protein, low carb'),
    'restrictions': TextEditingController(text: 'None'),
    'calories': TextEditingController(text: '2200'),
  });

  @override
  void dispose() {
    state.forEach((key, controller) => controller.dispose());
    super.dispose();
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, Map<String, TextEditingController>>((ref) {
  return UserProfileNotifier();
});