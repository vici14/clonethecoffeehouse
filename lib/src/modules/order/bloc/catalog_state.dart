import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/product_entity.dart';

enum CatalogTypes { POPULAR, DRINK, FOOD }

class CatalogState extends BaseState {
  final List<ProductEntity> products;

  CatalogState(
      {List<ProductEntity> products, CatalogState state, bool isLoading})
      : products = products ?? state?.products,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecondsSinceEpoch);
}
//
//class DrinksCatalogState extends BaseState {
//  final List<ProductEntity> drinks;
//
//  DrinksCatalogState(
//      {List<ProductEntity> products, DrinksCatalogState state, bool isLoading})
//      : drinks = products ?? state?.drinks,
//        super(
//            isLoading: isLoading ?? state?.isLoading,
//            timeStamp: DateTime.now().millisecondsSinceEpoch);
//}
//
//class CakesCatalogState extends BaseState {
//  final List<ProductEntity> cakes;
//
//  CakesCatalogState(
//      {List<ProductEntity> products, CakesCatalogState state, bool isLoading})
//      : cakes = products ?? state?.cakes,
//        super(
//            isLoading: isLoading ?? state?.isLoading,
//            timeStamp: DateTime.now().millisecondsSinceEpoch);
//}
