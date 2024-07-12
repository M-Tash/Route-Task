import '../../../domain/entities/ProductsResponseEntity.dart';

class ProductsResponseDto extends ProductsResponseEntity {
  ProductsResponseDto({
    super.products,
    super.total,
    super.skip,
    super.limit,
  });

  factory ProductsResponseDto.fromJson(dynamic json) {
    return ProductsResponseDto(
      products: json['products'] != null
          ? (json['products'] as List)
              .map((v) => ProductsDto.fromJson(v))
              .toList()
          : [],
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}

class ProductsDto extends ProductsEntity {
  ProductsDto({
    super.id,
    super.title,
    super.description,
    super.category,
    super.price,
    super.discountPercentage,
    super.rating,
    super.stock,
    super.tags,
    super.brand,
    super.sku,
    super.weight,
    super.dimensions,
    super.warrantyInformation,
    super.shippingInformation,
    super.availabilityStatus,
    super.reviews,
    super.returnPolicy,
    super.minimumOrderQuantity,
    this.meta,
    super.images,
    super.thumbnail,
  });

  factory ProductsDto.fromJson(dynamic json) {
    return ProductsDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] as double?,
      discountPercentage: json['discountPercentage'] is int
          ? (json['discountPercentage'] as int).toDouble()
          : json['discountPercentage'] as double?,
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'] as double?,
      stock: json['stock'],
      tags: json['tags'] != null ? json['tags'].cast<String>() : [],
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: json['dimensions'] != null
          ? DimensionsDto.fromJson(json['dimensions'])
          : null,
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((v) => ReviewsDto.fromJson(v))
              .toList()
          : [],
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      images: json['images'] != null ? json['images'].cast<String>() : [],
      thumbnail: json['thumbnail'],
    );
  }

  Meta? meta;
}

class DimensionsDto extends DimensionsEntity {
  DimensionsDto({
    super.width,
    super.height,
    super.depth,
  });

  factory DimensionsDto.fromJson(dynamic json) {
    return DimensionsDto(
      width: json['width'] is int
          ? (json['width'] as int).toDouble()
          : json['width'] as double?,
      height: json['height'] is int
          ? (json['height'] as int).toDouble()
          : json['height'] as double?,
      depth: json['depth'] is int
          ? (json['depth'] as int).toDouble()
          : json['depth'] as double?,
    );
  }
}

class ReviewsDto extends ReviewsEntity {
  ReviewsDto({
    super.rating,
    super.comment,
    super.date,
    super.reviewerName,
    super.reviewerEmail,
  });

  factory ReviewsDto.fromJson(dynamic json) {
    return ReviewsDto(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class Meta {
  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  factory Meta.fromJson(dynamic json) {
    return Meta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }

  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['barcode'] = barcode;
    map['qrCode'] = qrCode;
    return map;
  }
}