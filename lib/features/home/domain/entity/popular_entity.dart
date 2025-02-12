class PopularProductEntity {
    final List<ProductEntity>? data;

    PopularProductEntity({
        this.data,
    });

}

class ProductEntity {
    final int? id;
    final String? name;
    final String? slug;
    final int? itemCategoryId;
    final int? taxId;
    final int? isFeatured;
    final String? flatPrice;
    final double? convertPrice;
    final String? currencyPrice;
    final String? price;
    final int? itemType;
    final int? status;
    final String? description;
    final String? caution;
    final String? thumb;
    final String? cover;
    final String? preview;
    final String? categoryName;
    final List<dynamic>? offer;

    ProductEntity({
        this.id,
        this.name,
        this.slug,
        this.itemCategoryId,
        this.taxId,
        this.isFeatured,
        this.flatPrice,
        this.convertPrice,
        this.currencyPrice,
        this.price,
        this.itemType,
        this.status,
        this.description,
        this.caution,
        this.thumb,
        this.cover,
        this.preview,
        this.categoryName,
        this.offer,
    });

}
