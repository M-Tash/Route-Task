import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;

  const CustomTextField(
      {super.key, required this.searchController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.h),
        hintText: "What do you search for?",
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: const Color.fromRGBO(6, 0, 79, 0.6),
        ),
        prefixIcon: Image.asset(
          'assets/icons/iconSearch.png',
          color: AppColors.primaryColor,
        ),
        border: buildBaseBorder(),
        enabledBorder: buildBaseBorder(),
        focusedBorder: buildBaseBorder().copyWith(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }

  OutlineInputBorder buildBaseBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    );
  }
}
