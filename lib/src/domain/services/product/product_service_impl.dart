import 'package:flutterclonethecoffeehouse/src/data/repository/products_repository.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/products_repository_impl.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/product_entity.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/product/product_service.dart';

class ProductServiceImpl implements ProductService {
  ProductsRepository _productRepository = ProductRepositoryImpl();

  @override
  Future<List<ProductEntity>> getProducts(List<String> categories) async {
    return (await _productRepository.getProducts(categories))
        ?.map((p) => ProductEntity.fromResponse(p))
        ?.toList();
  }
}
