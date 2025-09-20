# Flutter News App - AI Agent Instructions

This document provides essential guidance for AI agents working in this Flutter news application codebase.

## Project Architecture

### Core Components
- **Modules (`lib/modules/`)**: Contains data models (e.g., `article.module.dart`) for news articles and responses
- **Services (`lib/services/`)**: API services like `news_api.service.dart` handling external data fetching
- **Screens (`lib/screens/`)**: UI views and widgets organized by feature
- **Widgets (`lib/widgets/`)**: Reusable custom widgets like `animated_tab_selector.dart` and `swipeable_stack.dart`

### Data Flow
1. News API Service (`NewsApiService`) fetches data using dio HTTP client
2. Data is parsed into Article models (`ArticleModel`, `FullArticelsModel`)
3. Views consume and display the article data

## Key Development Workflows

### Setup & Dependencies
```yaml
# Key dependencies from pubspec.yaml
dio: ^5.9.0                      # HTTP client
cached_network_image: ^3.4.1     # Image caching
webview_flutter: ^4.13.0         # In-app web content
```

### Building & Running
- Project uses standard Flutter commands
- Native splash screen configured in pubspec.yaml
- Assets located in `assets/images/`

## Project Patterns & Conventions

### API Integration
- NewsAPI.org integration with API key
- Two main endpoints: top headlines by category and search
- Error handling pattern using try-catch with Exception throwing

### UI/UX Patterns
- Dark theme by default (`MaterialApp` in main.dart)
- Image assets referenced from assets/images/
- Custom widgets for specialized UI components

### State Management
- Currently using stateful widgets
- No global state management solution implemented yet

## Integration Points

### External Services
- NewsAPI.org for content (`news_api.service.dart`)
  - Endpoint: https://newsapi.org/v2/
  - Required header: apiKey

### Platform Integration
- Native splash screen configuration
- WebView for article viewing
- Image caching for performance

## Common Tasks

### Adding New Features
1. Create new model in `lib/modules/` if needed
2. Add service methods in `lib/services/` for API integration
3. Implement UI components in `lib/screens/` or `lib/widgets/`

### Error Handling
Follow the established pattern:
```dart
try {
  // API call or operation
} catch (e) {
  throw Exception('Descriptive error message: $e');
}
```