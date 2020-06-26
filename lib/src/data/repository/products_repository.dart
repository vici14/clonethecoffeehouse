import 'dart:async';

import 'package:flutterclonethecoffeehouse/src/data/repository/models/entities.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getProducts(List<String> category);

//  Future<void> updateProduct(Product product);

}
