import 'package:ecommerce_app/features/products/data/models/product_model.dart';

abstract class ProductsLocalData {
  Future<ProductModel> getLastProduct();
  Future<void> cacheProduct(ProductModel product);
}