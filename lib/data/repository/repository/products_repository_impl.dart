import 'package:dartz/dartz.dart';

import '../../../domain/entities/ProductsResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/products_remote_data_source.dart';
import '../../../domain/repository/repository/products_repository.dart';
class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, ProductsResponseEntity>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }
}
