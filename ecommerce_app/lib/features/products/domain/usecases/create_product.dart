import '../entities/product.dart';
import 'package:dartz/dartz.dart';
import '../repo/products_repo.dart';
import '../../../../core/error/failure.dart';

class InsertProduct {
  final ProductRepository repo;
  final Product product;

  InsertProduct({
    required this.repo,
    required this.product
  });

  Future<Either<Failure, Product>> execute(Product product) {
    return repo.insertProduct(product);
  }
}