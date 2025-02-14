import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/entity/popular_entity.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/repository/home_repository.dart';

class HomeUsecase {
  final HomeRepository repository;
  HomeUsecase({required this.repository});

  Future<Either<Failure,PopularProductEntity>> call()async{
  return await repository.fetchPopularData();
  }
  
}