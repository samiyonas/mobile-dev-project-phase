import 'package:dartz/dartz.dart';
import '../repo/products_repo.dart';
import '../entities/product.dart';
import '../../../../core/error/failure.dart';

class DeleteProduct {
  final ProductRepo repo;
  final Product product;

  DeleteProduct({
    required this.repo,
    required this.product
  });

  Future<Either<Failure, void>> execute(int id) {
    return repo.deleteProduct(id);
  }
}