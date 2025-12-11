# Usage & Developer Workflow

This file explains how to run, test, and build the app locally.

Prerequisites

- Install Flutter (stable channel recommended). See https://docs.flutter.dev/get-started/install
- Xcode for iOS, Android Studio or SDK tools for Android.

Common commands

- Get dependencies:

```bash
flutter pub get
```

- Run the app on the default connected device/emulator:

```bash
flutter run
```

- Run on a specific device (list devices first):

```bash
flutter devices
flutter run -d <device-id>
```

- Run tests:

```bash
flutter test
```

- Run analyzer:

```bash
flutter analyze
```

- Build APK (Android):

```bash
flutter build apk --release
```

- Build iOS (requires macOS with Xcode):

```bash
flutter build ios --release
```

Testing guidance

- Unit tests: Put under `test/` and use mocked dependencies for domain/usecase tests.
- Widget tests: Use `flutter_test` and provide mocked usecases or repositories.

Environment & API configuration

- If the app communicates with a backend, set base URLs and API keys in a secure place (e.g., using `--dart-define` or a `.env` file with a secure loader).
- Example using a compile-time define:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

Debugging tips

- Use `flutter logs` or an IDE (VS Code/Android Studio) to view logs.
- Add `print` or `debugPrint` strategically when diagnosing issues.

Contributing

- Follow the existing architecture and folder conventions.
- Add tests for new business logic and repository mappings.
- Keep UI logic thin and put business rules into usecases/entities.

This is a compact guide to get started. If you need project-specific environment keys or backend details, check with your backend/configuration owner or the team.
