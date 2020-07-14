import 'package:flutter/widgets.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/order/bloc/catalog_state.dart';

abstract class BaseCatalogViewStateState<Sf extends StatefulWidget>
    extends State<Sf> {
  CatalogBloc bloc;
  BaseCatalogViewStateState({CatalogTypes type}) {
    bloc = CatalogBloc(type: type);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
