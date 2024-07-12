import '../../../../../domain/entities/failures.dart';
import '../../../domain/entities/ProductsResponseEntity.dart';

abstract class ProductListStates {}

class ProductListInitialState extends ProductListStates {}

class ProductListLoadingState extends ProductListStates {}

class ProductListErrorState extends ProductListStates {
  Failures? errors;

  ProductListErrorState({required this.errors});
}

final class ProductListSuccessState extends ProductListStates {
  ProductsResponseEntity productsResponseEntity;

  ProductListSuccessState({required this.productsResponseEntity});
}

class ProductSearchLoadingState extends ProductListStates {}

class ProductSearchErrorState extends ProductListStates {
  Failures? errors;

  ProductSearchErrorState({required this.errors});
}

final class ProductSearchSuccessState extends ProductListStates {
  ProductsResponseEntity productsResponseEntity;

  ProductSearchSuccessState({required this.productsResponseEntity});
}
