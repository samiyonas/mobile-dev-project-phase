 # ecommerce_app
 
 A Flutter e-commerce sample app — organized with a Clean Architecture style to keep UI, business logic, and data layers decoupled.
 
 Table of contents
 
 - [Overview](#overview)
 - [Architecture](#architecture)
 - [Data Flow](#data-flow)
 - [Project Structure](#project-structure)
 - [Getting Started](#getting-started)
 - [Development Workflow](#development-workflow)
 - [Testing](#testing)
 ## Overview
 
 This repository is a Flutter-based e-commerce application arranged to promote testability and separation of concerns. The app divides responsibilities across Presentation, Domain, and Data layers so UI code talks to usecases, usecases talk to abstract repositories, and repository implementations coordinate datasources and model mapping.
 
 ## Architecture
 
 High-level layers
 
 - Presentation (UI): Widgets, pages, and state management live here. The presentation layer depends only on the domain layer interfaces.
 - Domain: Pure business logic — entities, abstract repository interfaces, and usecases that encapsulate single business operations.
 - Data: Concrete implementations of repositories, data sources (remote/local), and models/DTOs that map to/from JSON and domain entities.
 
 Key patterns used
 
 - Entities vs Models: Domain `entities` represent business objects. Data `models` (in `lib/features/.../data/models`) convert to/from JSON and provide `toEntity()` helpers.
 - Repositories: Domain defines repository interfaces (`lib/features/<feature>/domain/repo`). Data provides `*RepositoryImpl` which implement those interfaces and call datasources.
 - Datasources: `RemoteDataSource` handles network calls; `LocalDataSource` (optional) handles caching/persistence.
 - Usecases: Small, focused classes in `lib/features/<feature>/domain/usecases`—each represents a single operation the app can perform (e.g., `GetProducts`).
 - Error handling: Low-level exceptions are converted to `Failure` objects in `lib/core/error` and returned upstream rather than exposing raw exceptions to the UI.
 
 Recommendations
 
 - Keep mapping logic inside the data layer and business rules inside usecases and entities.
 - Use dependency injection (a single `injection` or `di` file) to register repositories, datasources, and usecases.
 - Write unit tests for usecases by mocking repository interfaces and write repository tests by mocking datasources.
 
 ## Data Flow
 
 Typical runtime example: Load products list
 
 1. UI triggers the `GetProducts` usecase (presentation layer).
 2. `GetProducts` calls the `ProductsRepository` interface (domain layer).
 3. `ProductsRepositoryImpl` (data layer) chooses a datasource (e.g., `RemoteDataSource`) and requests JSON data.
 4. `RemoteDataSource` performs an HTTP request and returns raw JSON or throws an error.
 5. Data layer maps JSON to `ProductModel` instances, then converts models to domain `Product` entities.
 6. If an error occurs, data layer converts exceptions to `Failure` objects and returns them upstream.
 7. Usecase returns either `Success(Product list)` or `Failure`, and the presentation layer responds by rendering data or showing an error state.
 
 Notes on async and error handling
 
 - Network calls are asynchronous and typically return `Future<Either<Failure, T>>` or `Future<T>` with exceptions mapped to `Failure` depending on your code style.
 - Keep UI state explicit: Loading → Success(data) → Error(failure).
 
 ## Project Structure (important folders)
 
 - `lib/main.dart` — app entrypoint and bootstrap.
 - `lib/core/` — shared utilities and error types.
 - `lib/features/products/` — product feature, split into:
	 - `data/` — models, datasources, repository implementations
	 - `domain/` — entities, repository interfaces, usecases
	 - `presentation/` — widgets, pages, state management
 - `test/` — unit and widget tests and fixtures
 
 Example minimal tree
 
 ```
 lib/
	 main.dart
	 core/
	 features/
		 products/
			 data/
				 datasources/
				 models/
				 repo/
			 domain/
				 entities/
				 repo/
				 usecases/
			 presentation/
 ```
 
 ## Getting Started
 
 Prerequisites
 
 - Flutter (stable) installed: https://docs.flutter.dev/get-started/install
 - macOS: Xcode for iOS builds; Android Studio or SDK tools for Android builds
 
 Install dependencies
 
 ```bash
 flutter pub get
 ```
 
 Run the app
 
 ```bash
 flutter run
 ```
 
 Run on a specific device
 
 ```bash
 flutter devices
 flutter run -d <device-id>
 ```
 
 Build
 
 - Android APK:
 
 ```bash
 flutter build apk --release
 ```
 - iOS (macOS + Xcode required):
 
 ```bash
 flutter build ios --release
 ```
 
 ## Development Workflow
 
 - Add feature: create `features/<feature>` with `data`, `domain`, `presentation` subfolders.
 - Keep UI code thin. Put business logic into usecases and entities.
 - Use dependency injection to register implementations of abstract repositories.
 - Use `dart format` and `flutter analyze` before committing.
 
 Suggested commands
 
 ```bash
 dart format .
 flutter analyze
 ```
 
 ## Testing
 
 Run all tests
 
 ```bash
 flutter test
 ```
 
 Testing guidance
 
 - Unit tests: test usecases and domain logic; mock repositories.
 - Repository tests: mock datasources and test mapping and failure conversion.
 - Widget tests: provide mocked usecases or repository results.
 
 Fixtures
 
 - Keep JSON fixtures in `test/fixtures/` and use them to validate `fromJson` mapping for models.
 
# ecommerce_app

This repository contains a Flutter e-commerce sample app.

## Documentation

- Architecture: `docs/ARCHITECTURE.md`
- Data flow: `docs/DATA_FLOW.md`
- Usage & Developer Workflow: `docs/USAGE.md`

## Getting Started

This project is a starting point for a Flutter application. To get up and running:

- Install Flutter: https://docs.flutter.dev/get-started/install
- Fetch dependencies: `flutter pub get`
- Run on an emulator or device: `flutter run`

Helpful resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For general Flutter documentation and API reference, see: https://docs.flutter.dev/
# ecommerce_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
