import 'package:flutter/cupertino.dart';
import 'entities.dart';
import 'package:equatable/equatable.dart';

class ProductResponseRepository {
  final String name;
  final String description;
  final String id;
  final int cost;
  final String imgUrl;
  final String category;

  ProductResponseRepository({
    this.id,
    this.name,
    this.description,
    this.category,
    this.imgUrl,
    this.cost,
  });

  @override
  List<Object> get props => [id, name, cost, imgUrl, description, category];

  static ProductResponseRepository fromEntity(ProductEntity entity) {
    return ProductResponseRepository(
        id: entity.id,
        name: entity.name,
        cost: entity.cost,
        imgUrl: entity.imgUrl,
        description: entity.description,
        category: entity.category);
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id,
      name,
      cost,
      imgUrl,
      description,
      category,
    );
  }
}

//  class Size {
//  String nameSize;
//  double cost;
//}
//
//class Topping {
//  String nameTopping;
//  double cost;
//}
