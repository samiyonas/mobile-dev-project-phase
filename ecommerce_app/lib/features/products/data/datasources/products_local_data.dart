import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ecommerce_app/core/error/exception.dart';

abstract class ProductsLocalDataSource {
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel product);
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductsLocalDataSourceImpl({required this.sharedPreferences});

  static const CACHED_PRODUCT = 'CACHED_PRODUCT';

  @override
  Future<ProductModel> getLastProduct() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCT);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Future.value(ProductModel.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) {
    final jsonString = json.encode(product.toJson());
    return sharedPreferences.setString(CACHED_PRODUCT, jsonString);
  }
}