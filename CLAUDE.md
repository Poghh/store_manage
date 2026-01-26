# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Store management Flutter application for inventory, retail sales, stock-in, and transaction tracking. Vietnamese-language store management system.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run application (different flavors)
flutter run -t lib/main.dart        # default
flutter run -t lib/main_dev.dart    # development
flutter run -t lib/main_stg.dart    # staging

# Code generation (after changing routes, models with freezed/json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze
```

## Architecture

### Feature-based + Layered Structure
```
lib/
├── config/           # AppConfig with Flavor enum (dev, stg)
├── core/
│   ├── DI/           # get_it dependency injection setup
│   ├── constants/    # AppColors, AppFonts, AppFontSizes, AppNumbers, AppStrings
│   ├── navigation/   # auto_route AppRouter + route_observer
│   ├── network/      # NetworkClient (dio), ConnectivityService
│   ├── storage/      # SecureStorage, Hive-based offline storage
│   ├── offline/      # Sync services (retail, stock_in, product_delete)
│   ├── services/     # Business services (RetailRevenueService, etc.)
│   ├── theme/        # AppTheme
│   └── widgets/      # Shared widgets
└── feature/
    ├── home/         # Dashboard with revenue summary
    ├── product/      # Product details, inventory management
    ├── stock_in/     # Stock intake flow
    ├── retail/       # Retail sales with payment methods
    ├── transactions/ # Transaction history
    ├── reports/      # Reports page
    ├── profile/      # User profile
    └── login/        # Authentication
```

### State Management
- Uses **flutter_bloc** with **Cubit** pattern
- Cubits in `feature/*/presentation/cubit/`
- States use **freezed** for immutability
- BlocProvider/MultiBlocProvider for injection, BlocListener for side effects, BlocBuilder for UI

### Dependency Injection
- **get_it** configured in `lib/core/DI/di.dart`
- Access via global `di` instance: `di<ServiceType>()`
- Services registered as lazy singletons, Cubits as factories

### Navigation
- **auto_route** for declarative routing
- Router defined in `lib/core/navigation/app_router.dart`
- Pages annotated with `@RoutePage()`
- Run build_runner after route changes

### Data Layer
- Models in `feature/*/data/models/` using freezed + json_serializable
- Repositories in `feature/*/data/repositories/`
- NetworkClient wraps dio for API calls

### Offline Support
- Hive for local persistence
- OfflineQueueStorage for pending operations
- Sync services auto-sync when connectivity restored

## Development Conventions

- **File naming**: snake_case
- **Class naming**: PascalCase
- Use constants from `core/constants/` - never hard-code colors, sizes, or display strings
- New pages: create in `feature/<name>/presentation/page/`, annotate with `@RoutePage()`, register in AppRouter, run build_runner
- Shared UI widgets: `feature/<name>/presentation/widgets/` or `core/widgets/`

## Key Dependencies

- **auto_route**: Navigation/routing
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **dio**: HTTP client
- **hive_flutter**: Local storage
- **freezed/json_serializable**: Code generation for models
- **flutter_secure_storage**: Secure credential storage
