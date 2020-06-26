import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/product/product_service.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/product/product_service_impl.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_event.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';

class CatalogBloc extends BlocBase<BaseEvent, CatalogState> {
  final ProductService _service = ProductServiceImpl();
  final CatalogTypes type;

  CatalogBloc({this.type});

  @override
  CatalogState get initialState => CatalogState(isLoading: true);

  @override
  Stream<CatalogState> mapEventToState(BaseEvent event) async* {
    if (event is GetCatalogEvent) {
      yield* _getProductsState(event);
    }
  }

  Stream<CatalogState> _getProductsState(GetCatalogEvent event) async* {
    yield CatalogState(state: state, isLoading: true);
    var _products = await _getProducts();
    yield CatalogState(state: state, isLoading: false, products: _products);
  }

  Future<List<ProductEntity>> _getProducts() async {
    List<String> _filter = [''];
    switch (type) {
      case CatalogTypes.POPULAR:
        _filter = ['popular'];
        break;
      case CatalogTypes.DRINK:
        _filter = [
          'ice_blend',
          'coffee',
          'cold_brew',
          'macchiato',
          'tea',
        ];
        break;
      case CatalogTypes.FOOD:
        _filter = ['cake'];
        break;
    }
    try {
      return await _service?.getProducts(_filter);
    } catch (ex) {
      debugPrint('getProducts: ${ex.toString()}');
    }
    return null;
  }

  getProducts() {
    add(GetCatalogEvent());
  }
}
