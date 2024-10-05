import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/respository/product_repo.dart';

class GetProductUsecase implements UseCase<List<ProductEntity>,NoParams>{
final ProductRepository productRepository;
  GetProductUsecase({required this.productRepository});
  
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async{
    return await productRepository.getProduct();
  }
}