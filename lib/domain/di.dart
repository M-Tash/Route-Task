import 'package:route_task/domain/repository/data_source/products_remote_data_source.dart';
import 'package:route_task/domain/repository/repository/products_repository.dart';
import 'package:route_task/domain/use_cases/get_all_products_use_case.dart';

import '../data/api/ApiManager.dart';
import '../data/repository/data_source/products_remote_data_source_impl.dart';
import '../data/repository/repository/products_repository_impl.dart';

GetAllProductsUseCase injectGetAllProductsUseCase() {
  return GetAllProductsUseCase(productsRepository: injectProductsRepository());
}

ProductsRepository injectProductsRepository() {
  return ProductsRepositoryImpl(
      remoteDataSource: injectProductsRemoteDataSource());
}

ProductsRemoteDataSource injectProductsRemoteDataSource() {
  return ProductsRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
