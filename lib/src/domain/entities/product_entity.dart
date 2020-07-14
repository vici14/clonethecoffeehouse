import 'package:flutterclonethecoffeehouse/src/data/models/product_repository.dart';

class ProductEntity {
  final String name;
  final String description;
  final String id;
  final int cost;
  final String imgUrl;
  final String category;

  String get priceValue => '${cost} đ';

  ProductEntity({
    this.id,
    this.name,
    this.description,
    this.category,
    this.imgUrl,
    this.cost,
  });

  factory ProductEntity.fromResponse(ProductResponseRepository pro) {
    return ProductEntity(
      id: pro?.id,
      name: pro?.name,
      description: pro?.description,
      cost: pro?.cost,
      imgUrl: pro.imgUrl,
      category: pro?.category,
    );
  }
}

//class Size {
//  final String small;
//  final String medium;
//  final String large;
//
//  Size({this.small, this.medium, this.large});
//}
