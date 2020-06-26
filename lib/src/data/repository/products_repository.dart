import 'dart:async';

import 'package:flutterclonethecoffeehouse/src/data/models/product_repository.dart';

abstract class ProductsRepository {
  Future<List<ProductResponseRepository>> getProducts(List<String> categories);

//  Future<void> updateProduct(Product product);

}
