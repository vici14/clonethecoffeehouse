import 'package:flutter/widgets.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';

import 'base_catalog_view_state.dart';

class PopularCatalogScreen extends StatefulWidget {
  @override
  State<PopularCatalogScreen> createState() {
    return _PopularCatalogScreenState();
  }
}

class _PopularCatalogScreenState
    extends BaseCatalogViewStateState<PopularCatalogScreen> {
  _PopularCatalogScreenState() : super(type: CatalogTypes.POPULAR);
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
