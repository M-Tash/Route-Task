import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_task/ui/product_list_screen/cubit/states.dart';

import '../../../domain/entities/ProductsResponseEntity.dart';
import '../../../domain/use_cases/get_all_products_use_case.dart';

class ProductListTabViewModel extends Cubit<ProductListStates> {
  GetAllProductsUseCase getAllProductsUseCase;

  ProductListTabViewModel({required this.getAllProductsUseCase})
      : super(ProductListInitialState());

  List<ProductsEntity> productList = [];
  List<ProductsEntity> filteredProductList = [];
  List<ProductsEntity> searchProductList = [];

  void getAllProducts(String category) async {
    emit(ProductListLoadingState());
    var either = await getAllProductsUseCase.invoke();
    either.fold((l) => emit(ProductListErrorState(errors: l)), (response) {
      productList = response.products ?? [];
      filteredProductList = productList
          .where((product) =>
              product.category?.toLowerCase() == category.toLowerCase())
          .toList();
      emit(ProductListSuccessState(
          productsResponseEntity:
              ProductsResponseEntity(products: filteredProductList)));
    });
  }

  static ProductListTabViewModel getBloc(context) => BlocProvider.of(context);

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchProductList = filteredProductList;
    } else {
      searchProductList = filteredProductList
          .where((product) =>
              product.title?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    }
    emit(ProductSearchSuccessState(
        productsResponseEntity:
            ProductsResponseEntity(products: searchProductList)));
  }

  void filterProductsByCategory(String category) {
    filteredProductList = productList
        .where((product) =>
            product.category?.toLowerCase() == category.toLowerCase())
        .toList();
    emit(ProductListSuccessState(
        productsResponseEntity:
            ProductsResponseEntity(products: filteredProductList)));
  }
}
