import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../domain/di.dart';
import '../../domain/entities/ProductsResponseEntity.dart';
import '../product_list_screen/cubit/product_list_tab_view_model.dart';
import '../utils/app_colors.dart';
import '../utils/custom_image_network.dart';
import '../utils/dialog_utils.dart';
import '../utils/my_assets.dart';

class ProductDetailsView extends StatelessWidget {
  static String routeName = "product-details-view";
  final ProductListTabViewModel viewModel = ProductListTabViewModel(
    getAllProductsUseCase: injectGetAllProductsUseCase(),
  );

  ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var selectedProduct = args['product'] as ProductsEntity;
    var productList = args['productList'] as List<ProductsEntity>;
    final double originalPrice = selectedProduct.price ?? 0.0;
    final double egyptOriginalPrice = originalPrice * 50;
    final double discountPercentage = selectedProduct.discountPercentage ?? 0.0;
    final double discount = originalPrice * (discountPercentage / 100);
    final double discountedPrice = originalPrice - discount;
    final double egyptDiscountedPrice = discountedPrice * 50;

    return BlocProvider<ProductListTabViewModel>(
      create: (context) => viewModel..getAllProducts(''),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text("Product details"),
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primaryColor,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20.sp,
                color: AppColors.darkPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.greyColor, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: ImageSlideshow(
                      initialPage: 0,
                      indicatorColor: AppColors.primaryColor,
                      indicatorBackgroundColor: AppColors.whiteColor,
                      indicatorBottomPadding: 20.h,
                      autoPlayInterval: 8000,
                      isLoop: true,
                      children: selectedProduct.images!
                          .map(
                            (url) => CustomImageWidget(
                              url: url,
                              animation: MyAssets.loadingAnimation,
                              fit: BoxFit.cover,
                              height: 300.h,
                              width: double.infinity,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        selectedProduct.title ?? '',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColors.darkPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Stock : ${selectedProduct.stock}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.darkPrimaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Image.asset(MyAssets.starIcon),
                          SizedBox(
                            width: 4.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              '${selectedProduct.rating}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.darkPrimaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkPrimaryColor,
                      ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReadMoreText(
                  selectedProduct.description ?? '',
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor.withOpacity(
                      0.7,
                    ),
                  ),
                  trimCollapsedText: ' Show More',
                  trimExpandedText: ' Show Less',
                  moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkPrimaryColor),
                  lessStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkPrimaryColor),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total price",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 18.sp,
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "EGP ${egyptDiscountedPrice.toStringAsFixed(0)}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 18.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 32.w,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          DialogUtils.showSnackBar(
                              context: context,
                              message: 'Item successfully added to cart!');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.add_shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Text("Add to cart",
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Frequently bought together',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor),
                  ),
                ),
                SizedBox(
                  height: 150, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ProductDetailsView.routeName,
                                arguments: {
                                  'product': productList[index],
                                  'productList': productList,
                                  'onAddToCart': () {}
                                });
                          },
                          child: CustomImageWidget(
                            url: productList[index].thumbnail ?? '',
                            animation: MyAssets.loadingAnimation,
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Customer Reviews",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkPrimaryColor,
                      ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedProduct.reviews!.length,
                  itemBuilder: (context, index) {
                    final review = selectedProduct.reviews![index];
                    return Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${review.reviewerName}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkPrimaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'Rating: ${review.rating}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              review.comment.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.darkPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
