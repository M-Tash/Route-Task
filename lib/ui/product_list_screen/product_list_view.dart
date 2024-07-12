import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:route_task/ui/product_list_screen/widgets/custom_search_with_shopping_cart.dart';
import 'package:route_task/ui/product_list_screen/widgets/grid_view_card_item.dart';

import '../../domain/di.dart';
import '../utils/my_assets.dart';
import 'cubit/product_list_tab_view_model.dart';
import 'cubit/states.dart';

class ProductListScreen extends StatefulWidget {
  static String routeName = "product-list-screen";
  final String category;

  const ProductListScreen({super.key, this.category = ''});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListTabViewModel viewModel = ProductListTabViewModel(
    getAllProductsUseCase: injectGetAllProductsUseCase(),
  );

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.getAllProducts(widget.category);
    viewModel.filterProductsByCategory(widget.category);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel.filterProductsByCategory(widget.category);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    viewModel.searchProducts(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProductListTabViewModel>(
        create: (context) => viewModel,
        child: BlocBuilder<ProductListTabViewModel, ProductListStates>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        MyAssets.logo,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomSearchWithShoppingCart(
                      searchController: _searchController,
                      onSearchChanged: (value) => _onSearchChanged(),
                    ),
                    SizedBox(height: 24.h),
                    if (state is ProductListLoadingState ||
                        state is ProductSearchLoadingState)
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Center(
                          child: Lottie.asset('assets/animations/loading.json',
                              width: 150),
                        ),
                      )
                    else if (state is ProductListErrorState)
                      Center(
                        child:
                            Text('Error: ${state.errors ?? "Unknown Error"}'),
                      )
                    else if (state is ProductSearchErrorState)
                      Center(
                        child:
                            Text('Error: ${state.errors ?? "Unknown Error"}'),
                      )
                    else if (state is ProductListSuccessState)
                      Expanded(
                        child: GridView.builder(
                          itemCount:
                              state.productsResponseEntity.products?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 2.4,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h),
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: GridViewCardItem(
                                productsEntity: state
                                    .productsResponseEntity.products![index],
                              ),
                            );
                          },
                        ),
                      )
                    else if (state is ProductSearchSuccessState)
                      Expanded(
                        child: GridView.builder(
                          itemCount:
                              state.productsResponseEntity.products?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 2.4,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h),
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: GridViewCardItem(
                                productsEntity: state
                                    .productsResponseEntity.products![index],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
