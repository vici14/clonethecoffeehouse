import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/models/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/products_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final productsCollection = Firestore.instance.collection('products');

  @override
  Future<List<ProductEntity>> getProducts(List<String> category) async {
    try {
      var products = await productsCollection
          .where('category', whereIn: category)
          .getDocuments();
      debugPrint('test getProducts');
      products.documents?.forEach((s) => debugPrint(s.data.toString()));
      debugPrint('test getProducts');
      if (products.documents.isNotEmpty) {
        return products.documents
            .map((snap) => ProductEntity.fromSnapshot(snap))
            .toList();
      }
    } catch (e) {
      debugPrint('getProducts: ${e.toString()}');
    }
    return [];
  }
}
