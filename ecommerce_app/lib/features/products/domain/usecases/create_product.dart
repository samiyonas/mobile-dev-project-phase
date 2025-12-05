import '../entities/product.dart';
import 'package:dartz/dartz.dart';
import '../repo/products_repo.dart';
import '../../../../core/error/failure.dart';

class CreateProduct {
  final ProductRepo repo;
  final Product product;

  CreateProduct({
    required this.repo,
    required this.product
  });

  Future<Either<Failure, Product>> execute(Product product) {
    return repo.insertProduct(product);
  }
}