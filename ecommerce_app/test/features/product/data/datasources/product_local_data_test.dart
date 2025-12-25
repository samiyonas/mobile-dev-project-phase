import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/data/datasources/products_local_data.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'dart:convert';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductsLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductsLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastProduct', () {
    final tProductModel = ProductModel.fromJson(json.decode(fixture('product.json')));
    test('should return ProductModel from SharedPreferences when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString('CACHED_PRODUCT'))
          .thenReturn('product.json');
      // act
      final result = await dataSource.getLastProduct();
      // assert
      verify(mockSharedPreferences.getString('CACHED_PRODUCT'));
      expect(result, equals(tProductModel));
    });

    test('should throw a CacheException when there is no cached value', () async {
      // arrange
      when(mockSharedPreferences.getString('CACHED_PRODUCT'))
          .thenReturn(null);
      // act
      final call = dataSource.getLastProduct;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheProduct', () {
    final tProductModel = ProductModel(
      id: 1,
      name: 'Test product',
      description: 'Test description',
      price: 9.99,
      imageUrl: 'http://example.com/image.png'
    );
    final tProductJsonString = json.encode(tProductModel.toJson());
    test('should call SharedPreferences to cache the data', () async {
      // act
      await dataSource.cacheProduct(tProductModel);
      // assert
      verify(mockSharedPreferences.setString(
          'CACHED_PRODUCT', tProductJsonString));
    });
  });
}
