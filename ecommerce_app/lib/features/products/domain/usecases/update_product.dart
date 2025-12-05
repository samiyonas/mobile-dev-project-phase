import 'package:dartz/dartz.dart';
import '../repo/products_repo.dart';
import '../entities/product.dart';
import '../../../../core/error/failure.dart';

class UpdateProduct {
  final ProductRepo repo;
  final Product product;

  UpdateProduct({
    required this.repo,
    required this.product
  });

  Future<Either<Failure, Product>> execute(Product product) {
    return repo.updateProduct(product);
  }
}