import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductEntity {
  final String id;
  final String name;
  final int cost;
  final String imgUrl;
  final String description;
  final String category;

  ProductEntity(this.id, this.name, this.cost, this.imgUrl, this.description,
      this.category);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "cost": cost,
      "imgUrl": imgUrl,
      "category": category,
      "description": description
    };
  }

  @override
  String toString() {
    return 'ProductEntity {id: $id, name: $name, cost: $cost, imgUrl: $imgUrl, description: $description, category: $category} ';
  }

  static ProductEntity fromJson(Map<String, Object> json) {
    return ProductEntity(
      json["id"] as String,
      json["name"] as String,
      json["cost"] as int,
      json["imgUrl"] as String,
      json["description"] as String,
      json["category"] as String,
    );
  }

  static ProductEntity fromSnapshot(DocumentSnapshot snap) {
    try {
      return ProductEntity(
        snap.documentID,
        snap.data['name'],
        snap.data['cost'],
        snap.data['imgUrl'],
        snap.data['category'],
        snap.data['description'],
      );
    } catch (ex) {
      return ProductEntity(
        'ID',
        'name',
        92942,
        'lwflwef',
        'wlkflwef',
        'fjkwkf',
      );
    }
  }

//  Map<String, Object> toDocument() {
//
//  }
}
