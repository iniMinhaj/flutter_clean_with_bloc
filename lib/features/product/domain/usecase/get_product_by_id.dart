import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/core/usecases/usecase.dart';

import '../entity/product_entity.dart';
import '../respository/product_repo.dart';


class GetProductByIdUsecase implements UseCase<ProductEntity, String>{
  final ProductRepository productRepository;

  GetProductByIdUsecase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(String params)async {
    return await productRepository.getProductById(params);
  }
}