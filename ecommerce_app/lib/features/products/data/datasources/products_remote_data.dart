import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce_app/core/error/exception.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> viewAllProducts();
  Future<ProductModel> getProduct(int id);
  Future<ProductModel> insertProduct(Product product);
  Future<ProductModel> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;

  ProductsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> viewAllProducts() async {
    final response = await client.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    final response = await client.get(Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id'));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(Product product) async {
    final response = await client.post(
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id'),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}