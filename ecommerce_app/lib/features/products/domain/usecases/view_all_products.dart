import '../entities/product.dart';
import '../repo/products_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

class ViewAllProductsUsecase {
  final ProductRepo repo;

  ViewAllProductsUsecase({
    required this.repo
  });

  Future<Either<Failure, List<Product>>> execute() {
    return repo.viewAllProducts();
  }
}