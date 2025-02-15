# flutter_clean_with_bloc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

/*

lib/
├── core/
│   ├── constants/          # App constants (colors, strings, etc.)
│   ├── utils/             # Utility functions, extensions, etc.
│   ├── errors/            # Custom exceptions and failures
│   ├── network/           # Dio interceptor, API service, etc.
│   └── theme/             # App themes
├── data/
│   ├── datasources/       # Remote and local data sources
│   ├── models/            # Data models (generated using quicktype.io)
│   ├── repositories/      # Repository implementations
│   └── api_service.dart  # API service class
├── domain/
│   ├── entities/          # Business entities
│   ├── repositories/      # Abstract repository classes
│   └── usecases/          # Use cases (business logic)
└── presentation/
    ├── blocs/             # BLoC classes
    ├── pages/             # Screens/pages
    ├── widgets/          # Reusable widgets
    └── routes/            # GoRouter configuration


*/