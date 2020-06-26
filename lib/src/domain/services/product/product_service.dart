import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';

abstract class ProductService {
  Future<List<ProductEntity>> getProducts(List<String> categories) {}
}
