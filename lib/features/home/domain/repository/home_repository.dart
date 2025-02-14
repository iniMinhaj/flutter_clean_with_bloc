import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/entity/popular_entity.dart';

abstract class HomeRepository {

  Future<Either<Failure,PopularProductEntity>> fetchPopularData();
}