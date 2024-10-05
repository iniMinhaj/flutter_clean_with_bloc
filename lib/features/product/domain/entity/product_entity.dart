import 'rating_entity.dart';

class ProductEntity {
    final int? id;
    final String? title;
    final double? price;
    final String? description;
    final String? category;
    final String? image;
    final RatingEntity? rating;

    ProductEntity({
        this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating,
    });

}




