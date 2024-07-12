class ProductsResponseEntity {
  ProductsResponseEntity({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  List<ProductsEntity>? products;
  int? total;
  int? skip;
  int? limit;
}

class ProductsEntity {
  ProductsEntity({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
  });

  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  DimensionsEntity? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<ReviewsEntity>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  List<String>? images;
  String? thumbnail;
}

class ReviewsEntity {
  ReviewsEntity({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;
}

class DimensionsEntity {
  DimensionsEntity({
    this.width,
    this.height,
    this.depth,
  });

  double? width;
  double? height;
  double? depth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    map['depth'] = depth;
    return map;
  }
}