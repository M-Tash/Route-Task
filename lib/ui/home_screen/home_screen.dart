import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_task/ui/home_screen/widgets/category_item.dart';
import 'package:route_task/ui/home_screen/widgets/row_section_widgets.dart';

import '../../domain/di.dart';
import '../product_list_screen/cubit/product_list_tab_view_model.dart';
import '../product_list_screen/product_list_view.dart';
import '../utils/my_assets.dart';
import 'widgets/annountcements_section.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categoryImages = [
    MyAssets.beautyCategory,
    MyAssets.furnitureCategory,
    MyAssets.groceriesCategory
  ];
  List<String> categoryNames = ['Beauty', 'Furniture', 'Groceries'];

  ProductListTabViewModel viewModel = ProductListTabViewModel(
    getAllProductsUseCase: injectGetAllProductsUseCase(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(MyAssets.logo),
                ),
                SizedBox(height: 18.h),
                AnnouncementsSection(),
                SizedBox(height: 16.h),
                const RowSectionWidget(name: 'Categories'),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 300.h,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductListScreen(
                                  category: categoryNames[index]),
                            ),
                          );
                        },
                        child: CategoryOrBrandItem(
                          categoryImage: categoryImages[index],
                          categoryName: categoryNames[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
