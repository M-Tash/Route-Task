import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/ProductsResponseEntity.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_image_network.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/my_assets.dart';

class GridViewCardItem extends StatefulWidget {
  final ProductsEntity productsEntity;

  const GridViewCardItem({super.key, required this.productsEntity});

  @override
  State<GridViewCardItem> createState() => _GridViewCardItemState();
}

class _GridViewCardItemState extends State<GridViewCardItem> {
  bool isWishListed = false;

  //todo: product
  @override
  Widget build(BuildContext context) {
    final double originalPrice = widget.productsEntity.price ?? 0.0;
    final double egyptOriginalPrice = originalPrice * 50;
    final double discountPercentage =
        widget.productsEntity.discountPercentage ?? 0.0;
    final double discount = originalPrice * (discountPercentage / 100);
    final double discountedPrice = originalPrice - discount;
    final double egyptDiscountedPrice = discountedPrice * 50;
    return Container(
      width: 191.w,
      height: 237.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CustomImageWidget(
                  url: widget.productsEntity.images?[0] ?? '',
                  animation: MyAssets.loadingAnimation,
                  fit: BoxFit.cover,
                  height: 140.h,
                  width: double.infinity,
                ),
              ),
              Positioned(
                  top: 5.h,
                  right: 10.w,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          // Shadow color and opacity
                          spreadRadius: 2,
                          // Spread radius
                          blurRadius: 4,
                          // Blur radius
                          offset:
                              const Offset(0, 2), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.whiteColor,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isWishListed = !isWishListed;
                          });
                        },
                        child: isWishListed == true
                            ? Image.asset(
                                MyAssets.favouriteIconSelected,
                                width: 24,
                                height: 24,
                              )
                            : Image.asset(
                                MyAssets.favouriteIconNotSelected,
                                width: 24,
                                height: 24,
                              ),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              widget.productsEntity.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.darkPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: [
                Text(
                  "EGP ${egyptDiscountedPrice.toStringAsFixed(0)}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "${egyptOriginalPrice.toStringAsFixed(0)} EGP",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.darkPrimaryColor,
                        // Change the color of the strikethrough line
                        decorationThickness: 2.0,
                        fontSize: 14.sp,
                        color: AppColors.darkPrimaryColor.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.w),
            child: Row(
              children: [
                Text(
                  "Review (${widget.productsEntity.rating})",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.darkPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Image.asset(
                  MyAssets.starIcon,
                ),
                const Spacer(
                  flex: 1,
                ),
                InkWell(
                  onTap: () {
                    DialogUtils.showSnackBar(
                        context: context,
                        message: 'Item successfully added to cart!');
                  },
                  splashColor: Colors.transparent,
                  child: Icon(
                    Icons.add_circle,
                    size: 32.sp,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
