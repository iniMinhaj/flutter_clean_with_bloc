import 'package:dio/dio.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/error/exception.dart';
import 'package:flutter_clean_with_bloc/core/network/api_services.dart';
import 'package:flutter_clean_with_bloc/features/home/data/model/popular_model.dart';

abstract class HomeDataSource {
  Future<PopularProductModel> fetchPopularData();
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiService apiService;

  HomeDataSourceImpl({required this.apiService});

  @override
  Future<PopularProductModel> fetchPopularData() async {
    try {
      final response =
          await apiService.get(endpoint: ApiEndpoints.popularItems);

      if (response.statusCode == 200) {
        final popularProductModel = PopularProductModel.fromJson(response.data);
        return popularProductModel;
      } else {
        // Handle API-specific errors (e.g., 400, 401, 500)
        final errorMessage =
            response.data['message'] ?? 'An unknown error occurred';
        throw ServerException(message: errorMessage);
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'An error occurred');
    }
  }
}
