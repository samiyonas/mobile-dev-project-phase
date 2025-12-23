import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';

abstract class ProductsRemoteData {
  Future<List<ProductModel>> viewAllProducts();
  Future<ProductModel> getProduct(int id);
  Future<ProductModel> insertProduct(Product product);
  Future<ProductModel> updateProduct(Product product);
  Future<void> deleteProduct(int id);
}