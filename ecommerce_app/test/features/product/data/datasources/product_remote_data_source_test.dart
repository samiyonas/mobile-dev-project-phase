import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/data/datasources/products_remote_data.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:ecommerce_app/core/error/exception.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProductsRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('viewAllProducts', () {
    test('should return List<ProductModel> when the response code is 200 (success)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://api.example.com/products')))
          .thenAnswer((_) async => http.Response(fixture('products.json'), 200));
      // act
      final result = await dataSource.viewAllProducts();
      // assert
      expect(result, isA<List<ProductModel>>());
      expect(result.length, equals(3)); // assuming there are 3 products in fixture
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://api.example.com/products')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.viewAllProducts;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getProduct', () {
    final tId = 1;
    test('should return ProductModel when the response code is 200 (success)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://api.example.com/products/$tId')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      final result = await dataSource.getProduct(tId);
      // assert
      expect(result, isA<ProductModel>());
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://api.example.com/products/$tId')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = dataSource.getProduct;
      // assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });

  group('insertProduct', () {
    final tProduct = ProductModel(
      id: 0,
      name: 'New Product',
      description: 'New Description',
      price: 19.99,
      imageUrl: 'http://example.com/new_image.png'
    );

    test('should return ProductModel when the response code is 201 (created)', () async {
      // arrange
      when(mockHttpClient.post(
        Uri.parse('https://api.example.com/products'),
        body: tProduct.toJson(),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 201));
      // act
      final result = await dataSource.insertProduct(tProduct);
      // assert
      expect(result, isA<ProductModel>());
    });

    test('should throw a ServerException when the response code is not 201', () async {
      // arrange
      when(mockHttpClient.post(
        Uri.parse('https://api.example.com/products'),
        body: tProduct.toJson(),
      )).thenAnswer((_) async => http.Response('Something went wrong', 400));
      // act
      final call = dataSource.insertProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('updateProduct', () {
    final tProduct = ProductModel(
      id: 1,
      name: 'Updated Product',
      description: 'Updated Description',
      price: 29.99,
      imageUrl: 'http://example.com/updated_image.png'
    );

    test('should return ProductModel when the response code is 200 (success)', () async {
      // arrange
      when(mockHttpClient.put(
        Uri.parse('https://api.example.com/products/${tProduct.id}'),
        body: tProduct.toJson(),
      )).thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      final result = await dataSource.updateProduct(tProduct);
      // assert
      expect(result, isA<ProductModel>());
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.put(
        Uri.parse('https://api.example.com/products/${tProduct.id}'),
        body: tProduct.toJson(),
      )).thenAnswer((_) async => http.Response('Something went wrong', 400));
      // act
      final call = dataSource.updateProduct;
      // assert
      expect(() => call(tProduct), throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () {
    final tId = 1;

    test('should complete normally when the response code is 204 (no content)', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse('https://api.example.com/products/$tId')))
          .thenAnswer((_) async => http.Response('', 204));
      // act
      await dataSource.deleteProduct(tId);
      // assert
      verify(mockHttpClient.delete(Uri.parse('https://api.example.com/products/$tId')));});

    test('should throw a ServerException when the response code is not 204', () async {
      // arrange
      when(mockHttpClient.delete(Uri.parse('https://api.example.com/products/$tId')))
          .thenAnswer((_) async => http.Response('Something went wrong', 400));
      // act
      final call = dataSource.deleteProduct;
      // assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });
}