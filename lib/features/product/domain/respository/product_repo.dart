import 'package:dartz/dartz.dart';
import 'package:flutter_clean_with_bloc/core/error/failure.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';

abstract class ProductRepository{
  Future<Either<Failure,List<ProductEntity>>> getProduct();

 

  //------------- [ All kind of operations demo - GET,POST,UPDATE,DELETE ] ---------------------

  Future<Either<Failure,ProductEntity>> getProductById(String productId); 
  /* Future<Either<Failure, ProductEntity>> postProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product);
  Future<Either<Failure, ProductEntity>> deletedProduct(String productId);
  Future<Either<Failure, List<ProductEntity>>> filterProduct(String filterText, Rating rating);
  Future<Either<Failure, List<ProductEntity>>> getFavorites();
  Future<Either<Failure, ProductEntity>> addToFavorite(ProductEntity product); // POST

  */
}

