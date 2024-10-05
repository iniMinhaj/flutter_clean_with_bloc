import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/features/product/data/datasource/product_remote_datasource.dart';
import 'package:flutter_clean_with_bloc/features/product/data/mapper/product_mapper.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/respository/product_repo.dart';

import '../../../../core/error/exception.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductRemoteDatasource productRemoteDatasource;

  ProductRepositoryImpl({required this.productRemoteDatasource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct() async{
    try{
    final productModelList = await productRemoteDatasource.getProducts();
    final productEntityList = productModelList.map((product)=> ProductMapper.productModelToEntity(product)).toList();
    return Right(productEntityList);
    }
    on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  } catch (e) {
    return Left(ServerFailure(message: 'Unexpected error: $e'));
  }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String productId) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
}