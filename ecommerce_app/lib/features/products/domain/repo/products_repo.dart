import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> viewAllProducts();
  Future<Either<Failure, Product>> viewProduct(int id);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(int id);
}