import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<Product>>> viewAllProducts();
  Future<Either<Failure, Product>> getProduct(int id);
  Future<Either<Failure, Product>> insertProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(int id);
}