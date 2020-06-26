import 'package:flutter/widgets.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';

import 'base_catalog_view_state.dart';

class DrinksCatalogScreen extends StatefulWidget {
  @override
  State<DrinksCatalogScreen> createState() {
    return _DrinksCatalogScreenState();
  }
}

class _DrinksCatalogScreenState
    extends BaseCatalogViewStateState<DrinksCatalogScreen> {
  _DrinksCatalogScreenState() : super(type: CatalogTypes.DRINK);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
