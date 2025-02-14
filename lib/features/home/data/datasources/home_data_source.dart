import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/core/network/api_services.dart';
import 'package:flutter_clean_with_bloc/features/home/data/model/popular_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure,PopularProductModel>> fetchPopularData();
}


class HomeDataSourceImpl implements HomeDataSource{
  final ApiService apiService;

 HomeDataSourceImpl({required this.apiService});
  
  @override
  Future<Either<Failure, PopularProductModel>> fetchPopularData() async{
    final result = await apiService.get(endpoint: ApiEndpoints.popularItems);
  return  result.fold((failure){
      return Left(ServerFailure(message: failure.message));
    }, (response){

      print("response = ${response.data}");

      if(response.statusCode == 200){
         // Parse the response into a UserModel
          try {
            final popularProductModel = PopularProductModel.fromJson(response.data);
            return Right(popularProductModel);
          } catch (e) {
            print("Failed to parse UserModel: $e");
            return Left(ServerFailure(message: 'Failed to parse response'));
          }
        } else {
          // Handle API-specific errors (e.g., 400, 401, 500)
          final errorMessage = response.data['message'] ?? 'An unknown error occurred';
          return Left(ServerFailure(message: errorMessage));
        }
      }

    );
  }

}