import 'package:flutter/widgets.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';

import 'base_catalog_view_state.dart';

class FoodCatalogScreen extends StatefulWidget {
  @override
  State<FoodCatalogScreen> createState() {
    return _FoodCatalogScreenState();
  }
}

class _FoodCatalogScreenState
    extends BaseCatalogViewStateState<FoodCatalogScreen> {
  _FoodCatalogScreenState() : super(type: CatalogTypes.FOOD);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
