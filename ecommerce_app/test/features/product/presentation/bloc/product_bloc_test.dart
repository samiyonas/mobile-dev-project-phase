import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_all_products.dart';
import 'package:ecommerce_app/features/products/domain/usecases/view_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/products/presentation/product_bloc.dart';
import 'package:ecommerce_app/features/products/presentation/product_event.dart';
import 'package:ecommerce_app/features/products/presentation/product_state.dart';

class MockViewAllProductsUsecase extends Mock
    implements ViewAllProductsUsecase {}

class MockGetProduct extends Mock implements GetProduct {}

class MockInsertProduct extends Mock implements InsertProduct {}

class MockUpdateProduct extends Mock implements UpdateProduct {}

class MockDeleteProduct extends Mock implements DeleteProduct {}

void main() {
  late ProductBloc bloc;
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockGetProduct mockGetProduct;
  late MockInsertProduct mockInsertProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;

  const tProduct = Product(
    id: 1,
    name: 'Test Product',
    description: 'Test Description',
    price: 10.0,
    imageUrl: 'https://example.com/image.png',
  );

  setUp(() {
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockGetProduct = MockGetProduct();
    mockInsertProduct = MockInsertProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();

    bloc = ProductBloc(
      viewAllProducts: mockViewAllProductsUsecase,
      getProduct: mockGetProduct,
      insertProduct: mockInsertProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
    );
  });

  test('initial state should be EmptyState', () {
    expect(bloc.state, isA<EmptyState>());
  });

  group('LoadAllProductEvent', () {
    test(
      'should emit [LoadingState, LoadedAllProductState] when data is gotten successfully',
      () async {
        when(mockViewAllProductsUsecase.execute())
            .thenAnswer((_) async => const Right([tProduct]));

        final expected = [
          isA<LoadingState>(),
          isA<LoadedAllProductState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const LoadAllProductEvent());
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async {
        when(mockViewAllProductsUsecase.execute())
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const LoadAllProductEvent());
      },
    );
  });

  group('GetSingleProductEvent', () {
    test(
      'should emit [LoadingState, LoadedSingleProductState] when data is gotten successfully',
      () async {
        when(mockGetProduct.execute(1))
            .thenAnswer((_) async => const Right(tProduct));

        final expected = [
          isA<LoadingState>(),
          isA<LoadedSingleProductState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const GetSingleProductEvent(1));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async {
        when(mockGetProduct.execute(1))
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const GetSingleProductEvent(1));
      },
    );
  });

  group('CreateProductEvent', () {
    test(
      'should emit [LoadingState, LoadedSingleProductState] when product is created successfully',
      () async {
        when(mockInsertProduct.execute(tProduct))
            .thenAnswer((_) async => const Right(tProduct));

        final expected = [
          isA<LoadingState>(),
          isA<LoadedSingleProductState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const CreateProductEvent(tProduct));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when creating product fails',
      () async {
        when(mockInsertProduct.execute(tProduct))
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const CreateProductEvent(tProduct));
      },
    );
  });

  group('UpdateProductEvent', () {
    test(
      'should emit [LoadingState, LoadedSingleProductState] when product is updated successfully',
      () async {
        when(mockUpdateProduct.execute(tProduct))
            .thenAnswer((_) async => const Right(tProduct));

        final expected = [
          isA<LoadingState>(),
          isA<LoadedSingleProductState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const UpdateProductEvent(tProduct));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when updating product fails',
      () async {
        when(mockUpdateProduct.execute(tProduct))
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const UpdateProductEvent(tProduct));
      },
    );
  });

  group('DeleteProductEvent', () {
    test(
      'should emit [LoadingState, EmptyState] when product is deleted successfully',
      () async {
        when(mockDeleteProduct.execute(1))
            .thenAnswer((_) async => const Right(null));

        final expected = [
          isA<LoadingState>(),
          isA<EmptyState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const DeleteProductEvent(1));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when deleting product fails',
      () async {
        when(mockDeleteProduct.execute(1))
            .thenAnswer((_) async => Left(ServerFailure()));

        final expected = [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        bloc.add(const DeleteProductEvent(1));
      },
    );
  });
}


