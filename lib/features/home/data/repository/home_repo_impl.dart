import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/features/home/data/datasources/home_data_source.dart';
import 'package:flutter_clean_with_bloc/features/home/data/mapper/popular_mapper.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/entity/popular_entity.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<Failure, PopularProductEntity>> fetchPopularData() async{
    final data = await homeDataSource.fetchPopularData();
   return data.fold((failure){
    return Left(Failure(message: failure.message));
   }, (popularProductModel){
     final popularProductEntity = PopularMapper.modelToEntity(popularProductModel);
     return Right(popularProductEntity);
   });

  }
}