import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/product_repository.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/products_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final productsCollection = Firestore.instance.collection('products');

  @override
  Future<List<ProductResponseRepository>> getProducts(
      List<String> category) async {
    try {
      var products = await productsCollection
          .where('category', whereIn: category)
          .getDocuments();
      debugPrint('test getProducts');
      products.documents?.forEach((s) => debugPrint(s.data.toString()));
      debugPrint('test getProducts');
      if (products.documents.isNotEmpty) {
        return products.documents
            .map((snap) => ProductResponseRepository.fromSnapshot(snap))
            .toList();
      }
    } catch (e) {
      debugPrint('getProducts: ${e.toString()}');
    }
    return [];
  }
}
