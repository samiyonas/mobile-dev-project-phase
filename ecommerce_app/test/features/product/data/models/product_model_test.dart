import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import '../../../../fixtures/fixture_reader.dart';
void main() {
  final tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    description: 'This is a test product',
    price: 9.99,
    imageUrl: 'http://example.com/image.jpg',
  );
  test(
    'should be subclass of Product entity',
    () async {
      expect(tProductModel, isA<Product>());
    }
  );

  group(
    'fromJson', 
    () {
      test(
        'should return a valid ProductModel when the JSON is correct',
        () async {
          final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));
          final result = ProductModel.fromJson(jsonMap);
          expect(result, tProductModel);
        } 
      );
    }
  );

  group(
    'toJson',
    () async {
      test(
        'should return a JSON map containing the proper data',
        () async {
          final result = tProductModel.toJson();
          final expectedMap = {
            'id': 1,
            'name': 'Test Product',
            'description': 'This is a test product',
            'price': 9.99,
            'imageUrl': 'http://example.com/image.jpg'
          };
          expect(result, expectedMap);
        }
      );
    }
  );
}