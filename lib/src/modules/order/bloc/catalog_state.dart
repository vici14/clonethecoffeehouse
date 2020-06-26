import 'package:equatable/equatable.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/models/product_repository.dart';

enum CatalogTypes { POPULAR, DRINK, FOOD }

class CatalogState extends BaseState {
  final List<ProductResponseRepository> products;

  CatalogState(
      {List<ProductResponseRepository> products,
      CatalogState state,
      bool isLoading})
      : products = products ?? state?.products,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecondsSinceEpoch);
}

class DrinksCatalogState extends BaseState {
  final List<ProductResponseRepository> drinks;

  DrinksCatalogState(
      {List<ProductResponseRepository> products,
      DrinksCatalogState state,
      bool isLoading})
      : drinks = products ?? state?.drinks,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecondsSinceEpoch);
}

class CakesCatalogState extends BaseState {
  final List<ProductResponseRepository> cakes;

  CakesCatalogState(
      {List<ProductResponseRepository> products,
      CakesCatalogState state,
      bool isLoading})
      : cakes = products ?? state?.cakes,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecondsSinceEpoch);
}
