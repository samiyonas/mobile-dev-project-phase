# Data Flow

This document describes the typical runtime flow of data in the app and how requests/results travel through layers.

Example: Loading a list of products

1. User interaction / UI
   - The user opens a products screen. The presentation layer (Widget / Controller / Bloc) triggers a call to a usecase (e.g., `GetProducts`).

2. Presentation -> Domain
   - The presentation code calls the usecase with required parameters.

3. Usecase -> Repository
   - The usecase calls a repository interface declared in the domain layer (e.g., `ProductsRepository`).

4. Repository (data layer) -> DataSource
   - The repository implementation (`ProductsRepositoryImpl`) decides where to fetch data from: `RemoteDataSource` (API) or `LocalDataSource` (cache). It calls the appropriate data source.

5. DataSource -> External API / Cache
   - `RemoteDataSource` makes an HTTP request to the backend and returns raw JSON.
   - `LocalDataSource` returns cached data if available.

6. Model mapping & error handling
   - The data layer maps raw JSON to data models (`ProductModel`) and converts these models to domain entities (`Product`) that the domain layer understands.
   - If the HTTP call fails, exceptions are caught and converted to `Failure` objects (see `lib/core/error`). These are returned upstream.

7. Returning to UI
   - The usecase returns either a success value (entities) or a failure. Presentation reacts accordingly: render list, show error message, or show loading states.

Notes on asynchronous flow and testing

- All network calls should be async and returning Future/Either (depending on your functional approach).
- Write unit tests for usecases by mocking repository interfaces.
- Write repository tests by mocking datasources.

Failure propagation

- Convert raw exceptions into domain-friendly `Failure` objects in the data layer; do not leak low-level exceptions to the UI.

Tips

- Keep UI state granular: Loading, Success(data), Error(failure).
- Consider adding a `Repository` caching strategy to reduce network usage.
- Log mapping errors and include helpful messages in `Failure` to aid debugging during development.
