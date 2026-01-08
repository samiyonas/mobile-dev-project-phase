import 'package:equatable/equatable.dart';

import '../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

/// Represents the initial state before any data is loaded.
class IntialState extends ProductState {
  const IntialState();
}

/// Represents an explicitly empty state (no products loaded or after deletion).
class EmptyState extends ProductState {
  const EmptyState();
}

/// Indicates that the app is currently fetching data.
class LoadingState extends ProductState {
  const LoadingState();
}

/// Represents the state where all products are successfully loaded.
class LoadedAllProductState extends ProductState {
  final List<Product> products;

  const LoadedAllProductState(this.products);

  @override
  List<Object?> get props => [products];
}

/// Represents the state where a single product is successfully retrieved.
class LoadedSingleProductState extends ProductState {
  final Product product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object?> get props => [product];
}

/// Indicates that an error has occurred during data retrieval or processing.
class ErrorState extends ProductState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}


