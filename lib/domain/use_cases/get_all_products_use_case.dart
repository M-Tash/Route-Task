import 'package:dartz/dartz.dart';

import '../entities/ProductsResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/products_repository.dart';

class GetAllProductsUseCase {
  ProductsRepository productsRepository;

  GetAllProductsUseCase({required this.productsRepository});

  Future<Either<Failures, ProductsResponseEntity>> invoke() {
    return productsRepository.getAllProducts();
  }
}
