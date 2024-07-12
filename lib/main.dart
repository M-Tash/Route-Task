import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:route_task/ui/home_screen/home_screen.dart';
import 'package:route_task/ui/product_details_screen/product_details_view.dart';
import 'package:route_task/ui/product_list_screen/product_list_view.dart';
import 'package:route_task/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            ProductListScreen.routeName: (context) => const ProductListScreen(),
            ProductDetailsView.routeName: (context) => ProductDetailsView(),
          },
          theme: AppTheme.mainTheme,
        );
      },
    );
  }
}
