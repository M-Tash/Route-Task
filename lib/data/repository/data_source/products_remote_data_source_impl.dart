import 'package:dartz/dartz.dart';

import '../../../domain/entities/ProductsResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/products_remote_data_source.dart';
import '../../api/ApiManager.dart';

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  ApiManager apiManager;

  ProductsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, ProductsResponseEntity>> getAllProducts() async {
    var either = await apiManager.getAllProducts();
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }
}
