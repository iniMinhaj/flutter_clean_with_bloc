import 'package:flutter_clean_with_bloc/features/product/data/mapper/rating_mapper.dart';
import 'package:flutter_clean_with_bloc/features/product/data/model/product_model.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';

class ProductMapper{
  static ProductEntity productModelToEntity(ProductModel productModel){
    return ProductEntity(
      id: productModel.id,
      title: productModel.title,
      image: productModel.image,
      description: productModel.description,
      category: productModel.category,
      price: productModel.price,
      rating: productModel.rating == null ? null : RatingMapper.ratingModelToEntity (
        productModel.rating!
      ),
    );
  }
}