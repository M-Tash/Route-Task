import 'package:dartz/dartz.dart';

import '../../domain/entities/failures.dart';
import '../model/ProductsResponseDto.dart';
import 'ApiConstants.dart';
import 'ApiHelper.dart';

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  ApiHelper apiHelper = ApiHelper.getInstance();

  Future<Either<Failures, ProductsResponseDto>> getAllProducts() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.productsApi);
    var result = await apiHelper.get(
        url: url, errorMessage: 'Failed to fetch Products. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        ProductsResponseDto.fromJson(jsonResponse),
      ),
    );
  }
}
