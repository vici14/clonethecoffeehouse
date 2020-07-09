import 'package:cloud_firestore/cloud_firestore.dart';

class ProductResponseRepository {
  final String id;
  final String name;
  final int cost;
  final String imgUrl;
  final String description;
  final String category;

  ProductResponseRepository(this.id, this.name, this.cost, this.imgUrl,
      this.description, this.category);

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

  static ProductResponseRepository fromJson(
      {String id, Map<String, Object> json}) {
    return ProductResponseRepository(
      json["id"] as String,
      json["name"] as String,
      json["cost"] as int,
      json["imgUrl"] as String,
      json["description"] as String,
      json["category"] as String,
    );
  }

  static ProductResponseRepository fromSnapshot(DocumentSnapshot snap) {
    try {
      return ProductResponseRepository(
        snap.documentID,
        snap.data['name'],
        snap.data['cost'],
        snap.data['imgUrl'],
        snap.data['category'],
        snap.data['description'],
      );
    } catch (ex) {
      return ProductResponseRepository(
        'ID',
        'name',
        92942,
        'lwflwef',
        'wlkflwef',
        'fjkwkf',
      );
    }
  }
}
