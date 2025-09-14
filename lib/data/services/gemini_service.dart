import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final Dio _dio;

  GeminiService(this._dio);

  // --- 1. REAL IMPLEMENTATION for Meal Analysis (Image + Text) ---
  Future<Map<String, dynamic>> analyzeMealImage(File image) async {
    // FIX: Trim whitespace from the API key
    final apiKey = dotenv.env['GEMINI_API_KEY']?.trim();

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API Key not found or is empty. Make sure it's in your .env file.");
    }
    final url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

    final prompt = """
      Analyze the meal in this image.
      Your response must be a single, raw JSON object and nothing else. Do not use markdown formatting (like ```json or ##).
      The JSON object must have the following keys:
      - "name": A short, descriptive name for the meal.
      - "description": A one-sentence description.
      - "ingredients": A list of detected ingredients.
      - "nutrition": An object with "calories", "protein_g", "carbs_g", "fat_g", and "fiber_g".
      Estimate the nutritional values for a standard serving size.
      """; // (prompt content is correct, trimmed for brevity)

    // ... rest of the function is the same
    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final requestBody = {
      "contents": [
        {
          "parts": [
            {"text": prompt},
            {"inline_data": {"mime_type": "image/jpeg", "data": base64Image}}
          ]
        }
      ]
    };

    try {
      final response = await _dio.post(url, data: requestBody);
      final content = response.data['candidates'][0]['content']['parts'][0]['text'];
      final jsonString = content.replaceAll("```json", "").replaceAll("```", "").trim();
      return jsonDecode(jsonString);
    } catch (e) {
      print("Error analyzing image: $e");
      rethrow;
    }
  }

  // --- 2. REAL IMPLEMENTATION for Meal Planning (Text Only) ---
  Future<Map<String, dynamic>> generateMealPlan(String preferences) async {
    // FIX: Trim whitespace from the API key
    final apiKey = dotenv.env['GEMINI_API_KEY']?.trim();

     if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API Key not found or is empty. Make sure it's in your .env file.");
    }
    final url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey";

    final prompt = """
      Based on the following user preferences: '$preferences', create a daily meal plan.
      Your response must be a single, raw JSON object and nothing else. Do not use markdown formatting (like ```json or ##).
      The JSON object must have two top-level keys: "daily_calories_target" (an integer) and "meals" (an object).
      The "meals" object must contain four keys: "breakfast", "lunch", "dinner", and "snacks".
      Each of these must be an object with two keys: "name" (a string) and "calories" (an integer).
      Ensure the total calories from all meals approximately matches the "daily_calories_target".
    """; // (prompt content is correct, trimmed for brevity)

    // ... rest of the function is the same
    final requestBody = {
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    };

    try {
      final response = await _dio.post(url, data: requestBody);
      final content = response.data['candidates'][0]['content']['parts'][0]['text'];
      final jsonString = content.replaceAll("```json", "").replaceAll("```", "").trim();
      return jsonDecode(jsonString);
    } catch (e) {
      print("Error generating meal plan: $e");
      rethrow;
    }
  }
}