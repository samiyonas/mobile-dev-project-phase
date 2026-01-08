import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../domain/entities/product.dart';
import '../domain/usecases/view_all_products.dart';
import '../domain/usecases/view_product.dart';
import '../domain/usecases/create_product.dart';
import '../domain/usecases/update_product.dart';
import '../domain/usecases/delete_product.dart';
import '../../../core/error/failure.dart' as core_failure;
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProducts;
  final GetProduct getProduct;
  final InsertProduct insertProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.viewAllProducts,
    required this.getProduct,
    required this.insertProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(const EmptyState());

  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadAllProductEvent) {
      yield const LoadingState();
      final Either<core_failure.Failure, List<Product>> result =
          await viewAllProducts.execute();

      yield result.fold(
        (failure) => ErrorState(_mapFailureToMessage(failure)),
        (products) => LoadedAllProductState(products),
      );
    } else if (event is GetSingleProductEvent) {
      yield const LoadingState();
      final Either<core_failure.Failure, Product> result =
          await getProduct.execute(event.id);

      yield result.fold(
        (failure) => ErrorState(_mapFailureToMessage(failure)),
        (product) => LoadedSingleProductState(product),
      );
    } else if (event is CreateProductEvent) {
      yield const LoadingState();
      final Either<core_failure.Failure, Product> result =
          await insertProduct.execute(event.product);

      yield result.fold(
        (failure) => ErrorState(_mapFailureToMessage(failure)),
        (product) => LoadedSingleProductState(product),
      );
    } else if (event is UpdateProductEvent) {
      yield const LoadingState();
      final Either<core_failure.Failure, Product> result =
          await updateProduct.execute(event.product);

      yield result.fold(
        (failure) => ErrorState(_mapFailureToMessage(failure)),
        (product) => LoadedSingleProductState(product),
      );
    } else if (event is DeleteProductEvent) {
      yield const LoadingState();
      final Either<core_failure.Failure, void> result =
          await deleteProduct.execute(event.id);

      yield result.fold(
        (failure) => ErrorState(_mapFailureToMessage(failure)),
        (_) => const EmptyState(),
      );
    }
  }

  String _mapFailureToMessage(core_failure.Failure failure) {
    if (failure is core_failure.ServerFailure) {
      return 'Server Failure';
    } else if (failure is core_failure.CacheFailure) {
      return 'Cache Failure';
    } else {
      return 'Unexpected Error';
    }
  }
}


