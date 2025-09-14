# AI Meal Analysis and Planning App

Gumm is a Flutter-based application designed to help users analyze meals and generate personalized meal plans. The app leverages AI-powered services to provide insights into meal composition, nutritional values, and tailored meal planning based on user preferences.

## 🏗️ Architecture Overview

The Gumm project is designed with modularity, scalability, and maintainability in mind. Below is a brief overview of the key architectural decisions:

### 1. Modular Folder Structure
The codebase is organized into clear, purpose-driven directories:
- `common/`: Shared utilities and reusable widgets.
- `config/`: App-wide configurations like routing and theming.
- `data/`: Models, providers, repositories, and services.
- `features/`: Feature-specific logic grouped by domain (e.g., meal analysis, planning, history).

This structure follows the Separation of Concerns principle for better code clarity and maintainability.

### 2. Feature-Based Architecture
Each feature resides in its own folder under `features/`, containing:
- `providers/`: Local state management.
- `screens/`: UI views.
- `widgets/`: Feature-specific reusable components.

This encapsulation allows independent development and testing of features.

### 3. Service-Oriented Design
Services in `data/services/` (e.g., `GeminiService`, `CameraService`) abstract external dependencies and expose clean interfaces for:
- API communication
- Local storage
- Device interaction

This promotes reusability and simplifies testing.

### 4. State Management with Provider
The app uses the `Provider` package for localized state management within each feature. This keeps logic simple and avoids global complexity.

### 5. Repository Pattern
Repositories in `data/repositories/` (e.g., `MealRepository`) decouple business logic from data sources, providing a unified interface for accessing APIs or local storage.

### 6. Environment Configuration
Using `flutter_dotenv`, environment variables (like API keys) are securely managed, allowing easy switching between development and production setups.

### 7. Robust Error Handling
- Services validate inputs and handle failures gracefully.
- UI components use reusable widgets like `ErrorDisplay` for consistent feedback.

### 8. Scalability
The architecture supports growth:
- New features can be added under `features/`.
- Services and repositories are easily extendable without breaking existing code.

### 9. Cross-Platform Support
Built with Flutter, the app runs on Android, iOS, and Web. Platform-agnostic packages like `dio` and `path_provider` ensure smooth cross-device compatibility.


---

## Features

- **Meal Analysis**: Upload an image of a meal to get its name, description, ingredients, and estimated nutritional values.
- **Meal Planning**: Generate a daily meal plan based on user preferences and calorie targets.
- **History and Analytics**: Track meal history and analyze nutritional trends over time.
- **Cross-Platform Support**: Available on Android, iOS, Web, Windows, Linux, and macOS.

---

## Project Structure

The project is organized as follows:

lib/
├── common/
│   ├── utils/
│   │   └── date_formatter.dart
│   ├── widgets/
│   │   ├── error_display.dart
│   │   ├── loading_indicator.dart
│   │   └── nutrient_display_chip.dart
├── config/
│   ├── navigation/
│   │   └── app_router.dart
│   └── theme/
│       └── app_theme.dart
├── data/
│   ├── models/
│   │   ├── meal_analysis.dart
│   │   ├── meal_plan.dart
│   │   └── user_profile.dart
│   ├── providers/
│   │   ├── dio_provider.dart
│   │   └── repository_providers.dart
│   ├── repositories/
│   │   └── meal_repository.dart
│   └── services/
│       ├── camera_service.dart
│       ├── gemini_service.dart
│       └── local_storage_service.dart
├── features/
│   ├── meal_analysis/
│   │   ├── providers/
│   │   │   └── meal_analysis_provider.dart
│   │   ├── screens/
│   │   │   └── meal_analysis_screen.dart
│   │   └── widgets/
│   │       ├── analysis_result_card.dart
│   │       └── meal_capture_button.dart
│   ├── meal_planner/
│   │   ├── providers/
│   │   │   ├── meal_plan_provider.dart
│   │   │   └── user_profile_provider.dart
│   │   ├── screens/
│   │   │   └── meal_planner_screen.dart
│   │   └── widgets/
│   │       ├── generated_plan_view.dart
│   │       └── preferences_form.dart
│   ├── history_analytics/
│   │   ├── providers/
│   │   │   └── meal_history_provider.dart
│   │   ├── screens/
│   │   │   ├── history_screen.dart
│   │   │   └── meal_detail_screen.dart
│   │   └── widgets/
│   │       ├── meal_history_list_item.dart
│   │       └── nutrition_trend_chart.dart
│   └── main_navigation/
│       └── screens/
│           └── main_navigation_scaffold.dart
└── main.dart



---

## Packages Used

The project utilizes the following Dart/Flutter packages:

- **[dio](https://pub.dev/packages/dio)**: For making HTTP requests to the Gemini API.
- **[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)**: For managing environment variables securely.
- **[provider](https://pub.dev/packages/provider)**: For state management across the app.
- **[camera](https://pub.dev/packages/camera)**: For capturing meal images.
- **[path_provider](https://pub.dev/packages/path_provider)**: For accessing the device's file system.
- **[json_annotation](https://pub.dev/packages/json_annotation)**: For serializing and deserializing JSON data.

---

## Getting Started

### Prerequisites

1. Install [Flutter](https://flutter.dev/docs/get-started/install) on your system.
2. Set up your environment variables:
   - Create a `.env` file in the root directory.
   - Add your Gemini API key:
     ```
     GEMINI_API_KEY=your_api_key_here
     ```

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/gumm.git

