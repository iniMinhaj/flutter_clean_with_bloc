import 'package:flutter_clean_with_bloc/features/home/data/model/popular_model.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/entity/popular_entity.dart';

class PopularMapper {

  static PopularProductEntity modelToEntity(PopularProductModel popularProductModel){
    return PopularProductEntity(
      data: popularProductModel.data?.map((product){
        return ProductEntity(
          id: product.id,
          name: product.name,
           categoryName: product.categoryName,
           caution: product.caution,
           convertPrice: product.convertPrice,
           cover: product.cover,
           currencyPrice: product.currencyPrice,
           description: product.description,
           thumb: product.thumb,
        );
      }).toList()
    );
  }
}