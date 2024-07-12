import 'package:dartz/dartz.dart';

import '../../entities/ProductsResponseEntity.dart';
import '../../entities/failures.dart';

abstract class ProductsRepository {
  Future<Either<Failures, ProductsResponseEntity>> getAllProducts();
}
