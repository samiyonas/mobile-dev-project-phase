# Architecture Overview

This project follows a Clean Architecture-inspired structure adapted for a Flutter app. The goal is to separate concerns, make the code testable, and keep UI, business rules, and data handling decoupled.

High-level layers

- Presentation
  - Where UI and state management live (widgets, blocs/providers/controllers). In this repo the feature presentation code is under `lib/features/<feature>/presentation`.
- Domain
  - Business rules and use cases. This layer contains abstract repositories, entities, and usecases under `lib/features/<feature>/domain`.
- Data
  - Concrete implementations for repositories, data sources (remote/local), and models (DTOs) under `lib/features/<feature>/data`.

Key concepts and patterns

- Entities vs Models:
  - Entities: pure business objects defined in `domain/entities`. They should not depend on framework packages.
  - Models (DTOs): located in `data/models`; these map to/from JSON and convert to Entities for the domain layer.

- Repositories:
  - The domain layer defines repository interfaces in `domain/repo` (abstract). The data layer provides concrete `RepositoryImpl` classes in `data/repo` that implement these interfaces and coordinate datasources + mapping.

- Data Sources:
  - `data/datasources` contains low-level data access implementations, typically `RemoteDataSource` (API calls) and optionally `LocalDataSource` (cache, DB).

- Usecases:
  - Usecases in `domain/usecases` encapsulate single business operations (e.g., `GetProducts`). Presentation calls usecases rather than calling repositories directly.

- Error handling:
  - Errors/failures are represented in `core/error` (e.g., `Failure` types); data layer maps exceptions into failure objects that propagate via the domain layer.

Repository layout (observed in this project)

- `lib/main.dart`: entrypoint and app bootstrap.
- `lib/core`: shared/core utilities like error classes.
- `lib/features/products/presentation`: UI layer for products (screens, widgets, controllers).
- `lib/features/products/domain`: entities, repository interfaces, and usecases.
- `lib/features/products/data`: models, datasources, and repository implementations.

Notes & recommendations

- Keep mapping code inside the data layer (e.g., `fromJson`, `toEntity`).
- Keep business logic inside usecases and entities; avoid placing logic directly in Widgets.
- If you add dependency injection, centralize the registration (e.g., `di/` or `injection_container.dart`) and wire repositories, datasources, and usecases there.

This architecture keeps the app modular and easy to test: unit tests target usecases and repository implementations; widget tests cover UI with mocked usecases.
