import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_master/data/models/meal_analysis.dart';
import 'package:meal_master/data/providers/repository_providers.dart';
import 'package:meal_master/data/services/camera_service.dart';
// ADD THIS IMPORT to get access to the mealHistoryProvider
import 'package:meal_master/features/3_history_analytics/providers/meal_history_provider.dart';

// 1. Define an enum for the possible states of our UI
enum MealAnalysisStatus { initial, loading, success, error }

// 2. Create an immutable state class to hold the data for our UI
class MealAnalysisState {
  final MealAnalysisStatus status;
  final MealAnalysis? analysis;
  final String? errorMessage;
  final File? imageFile; // Optional: to display the captured image

  MealAnalysisState({
    this.status = MealAnalysisStatus.initial,
    this.analysis,
    this.errorMessage,
    this.imageFile,
  });

  // Helper method to easily create copies of the state
  MealAnalysisState copyWith({
    MealAnalysisStatus? status,
    MealAnalysis? analysis,
    String? errorMessage,
    File? imageFile,
  }) {
    return MealAnalysisState(
      status: status ?? this.status,
      analysis: analysis ?? this.analysis,
      errorMessage: errorMessage ?? this.errorMessage,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

// 3. Create the StateNotifier class
// This is the "brain" that will manage our MealAnalysisState
class MealAnalysisNotifier extends StateNotifier<MealAnalysisState> {
  final Ref _ref;
  final CameraService _cameraService = CameraService();

  MealAnalysisNotifier(this._ref) : super(MealAnalysisState());

  // Public method to be called from the UI to start analysis from the camera
  Future<void> analyzeMealFromCamera() async {
    final image = await _cameraService.pickImageFromCamera();
    if (image != null) {
      _analyzeImage(image);
    }
  }

  // Public method to be called from the UI to start analysis from the gallery
  Future<void> analyzeMealFromGallery() async {
    final image = await _cameraService.pickImageFromGallery();
    if (image != null) {
      _analyzeImage(image);
    }
  }

  // Private method to handle the core analysis logic
  Future<void> _analyzeImage(File image) async {
    // Set the state to loading immediately
    state = state.copyWith(status: MealAnalysisStatus.loading, imageFile: image);
    try {
      // Read the repository from the provider
      final repository = _ref.read(mealRepositoryProvider);
      // Call the repository to get the analysis and save it
      final result = await repository.analyzeAndSaveMeal(image);
      // If successful, update the state with the success status and the data
      state = state.copyWith(status: MealAnalysisStatus.success, analysis: result);

      // --- FIX: Invalidate the history provider to trigger a refresh ---
      _ref.invalidate(mealHistoryProvider);
      
    } catch (e) {
      // If an error occurs, update the state with the error status and a message
      state = state.copyWith(
        status: MealAnalysisStatus.error,
        errorMessage: "Failed to analyze meal. Please try again.",
      );
    }
  }

  // Public method to reset the state back to its initial value
  void reset() {
    state = MealAnalysisState();
  }
}

// 4. Create the final provider
// This is what the UI will "watch" to get the state and the notifier instance
final mealAnalysisProvider = StateNotifierProvider.autoDispose<MealAnalysisNotifier, MealAnalysisState>((ref) {
  return MealAnalysisNotifier(ref);
});