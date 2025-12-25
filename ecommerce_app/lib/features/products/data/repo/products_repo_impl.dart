import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import '../../domain/repo/products_repo.dart';
import '../../domain/entities/product.dart';
import '../datasources/products_remote_data.dart';
import '../datasources/products_local_data.dart';

class ProductsRepoImpl implements ProductRepository {
  final NetWorkInfo networkInfo;
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;

  const ProductsRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return Right(null);
      } catch (e) {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteProduct =  await remoteDataSource.getProduct(id);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await localDataSource.getLastProduct();
        return Right(localProduct);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteProduct = await remoteDataSource.insertProduct(product);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> viewAllProducts() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteProducts = await remoteDataSource.viewAllProducts();
        localDataSource.cacheProduct(remoteProducts.first);
        return Right(remoteProducts);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteProduct = await remoteDataSource.updateProduct(product);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}