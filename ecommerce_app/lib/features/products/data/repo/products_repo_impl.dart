import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import '../../domain/repo/products_repo.dart';
import '../../domain/entities/product.dart';
import '../datasources/products_remote_data.dart';
import '../datasources/products_local_data.dart';

class ProductsRepoImpl implements ProductRepository {
  final NetWorkInfo networkInfo;
  final ProductsRemoteData remoteDataSource;
  final ProductsLocalData localDataSource;

  const ProductsRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> viewAllProducts() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) {
    throw UnimplementedError();
  }
}