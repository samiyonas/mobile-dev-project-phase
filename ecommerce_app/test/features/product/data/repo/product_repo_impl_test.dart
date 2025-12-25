import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/products/data/repo/products_repo_impl.dart';
import 'package:ecommerce_app/features/products/data/datasources/products_remote_data.dart';
import 'package:ecommerce_app/features/products/data/datasources/products_local_data.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';

class MockNetworkInfo extends Mock implements NetWorkInfo {}
class MockProductsRemoteData extends Mock implements ProductsRemoteDataSource {}
class MockProductsLocalData extends Mock implements ProductsLocalDataSource {}


void main() {
  late ProductsRepoImpl productsRepoImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockProductsRemoteData mockProductsRemoteData;
  late MockProductsLocalData mockProductsLocalData;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockProductsRemoteData = MockProductsRemoteData();
    mockProductsLocalData = MockProductsLocalData();
    productsRepoImpl = ProductsRepoImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockProductsRemoteData,
      localDataSource: mockProductsLocalData,
    );
  });

  group(
    'viewAllProducts',
    () {
      final tProductModel = ProductModel(
        id: 1,
        name: 'Test Product',
        description: 'This is a test product',
        price: 9.99,
        imageUrl: 'http://example.com/image.jpg',
      );
      final tProduct = tProductModel;
      final tProductList = [tProductModel];
      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          productsRepoImpl.viewAllProducts();
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.viewAllProducts();
          // assert
          verify(mockProductsRemoteData.viewAllProducts());
          verify(mockProductsLocalData.cacheProduct(tProduct));
          expect(result, equals(Right(tProductList)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.viewAllProducts();
          // assert
          verify(mockProductsRemoteData.viewAllProducts());
          verifyZeroInteractions(mockProductsLocalData);
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return last locally cached data if present when the device is offline',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final result = productsRepoImpl.viewAllProducts();
          // assert
          verifyZeroInteractions(mockProductsRemoteData);
          verify(mockProductsLocalData.getLastProduct());
          expect(result, equals(Right(tProductList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final result = productsRepoImpl.viewAllProducts();
          // assert
          verifyZeroInteractions(mockProductsRemoteData);
          verify(mockProductsLocalData.getLastProduct());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );

  group(
    'getProduct',
    () {
      final tId = 1;
      final tProductModel = ProductModel(
        id: tId,
        name: 'Test Product',
        description: 'This is a test product',
        price: 9.99,
        imageUrl: 'http://example.com/image.jpg',
      );
      final tProduct = tProductModel;

      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          productsRepoImpl.getProduct(tId);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.getProduct(tId);
          // assert
          verify(mockProductsRemoteData.getProduct(tId));
          verify(mockProductsLocalData.cacheProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.getProduct(tId);
          // assert
          verify(mockProductsRemoteData.getProduct(tId));
          verifyZeroInteractions(mockProductsLocalData);
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return last locally cached data if present when the device is offline',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final result = productsRepoImpl.getProduct(tId);
          // assert
          verifyZeroInteractions(mockProductsRemoteData);
          verify(mockProductsLocalData.getLastProduct());
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final result = productsRepoImpl.getProduct(tId);
          // assert
          verifyZeroInteractions(mockProductsRemoteData);
          verify(mockProductsLocalData.getLastProduct());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );

  group(
    'insertProduct',
    () {
      final tProductModel = ProductModel(
        id: 1,
        name: 'Test Product',
        description: 'This is a test product',
        price: 9.99,
        imageUrl: 'http://example.com/image.jpg',
      );
      final tProduct = tProductModel;

      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          productsRepoImpl.insertProduct(tProduct);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.insertProduct(tProduct);
          // assert
          verify(mockProductsRemoteData.insertProduct(tProduct));
          verify(mockProductsLocalData.cacheProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.insertProduct(tProduct);
          // assert
          verify(mockProductsRemoteData.insertProduct(tProduct));
          verifyZeroInteractions(mockProductsLocalData);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    },
  );

  group(
    'updateProduct',
    () {
      final tProductModel = ProductModel(
        id: 1,
        name: 'Test Product',
        description: 'This is a test product',
        price: 9.99,
        imageUrl: 'http://example.com/image.jpg',
      );
      final tProduct = tProductModel;

      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          productsRepoImpl.updateProduct(tProduct);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.updateProduct(tProduct);
          // assert
          verify(mockProductsRemoteData.updateProduct(tProduct));
          verify(mockProductsLocalData.cacheProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.updateProduct(tProduct);
          // assert
          verify(mockProductsRemoteData.updateProduct(tProduct));
          verifyZeroInteractions(mockProductsLocalData);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    },
  );

  group(
    'deleteProduct',
    () {
      final tId = 1;

      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          productsRepoImpl.deleteProduct(tId);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.deleteProduct(tId);
          // assert
          verify(mockProductsRemoteData.deleteProduct(tId));
          expect(result, equals(Right(null)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          final result = productsRepoImpl.deleteProduct(tId);
          // assert
          verify(mockProductsRemoteData.deleteProduct(tId));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    },
  );
}