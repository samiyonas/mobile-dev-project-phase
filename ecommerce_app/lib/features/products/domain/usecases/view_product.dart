import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../repo/products_repo.dart';

class GetProduct {
  final ProductRepo repo;

  GetProduct({
    required this.repo
  });

  Future<Either<Failure, Product>> execute(int id) {
    return repo.getProduct(id);
  }
}