import 'package:flutter_clean_with_bloc/features/product/data/model/product_model.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/rating_entity.dart';

class RatingMapper{

  static RatingEntity ratingModelToEntity(Rating rating){
    return RatingEntity(
      count: rating.count,
      rate: rating.rate,
    );
  }
}