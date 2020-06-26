import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/product_repository.dart';

class ProductDetailState extends BaseState {
  final ProductResponseRepository product;
  int quantity;
  bool isActive;
  Size size;
  ProductDetailState(
      {ProductResponseRepository product,
      ProductDetailState state,
      this.isActive,
      this.quantity,
      this.size})
      : product = product ?? state?.product,
        super(timeStamp: DateTime.now().millisecondsSinceEpoch);
}

class Size {
  final String small;
  final String medium;
  final String large;

  Size(this.small, this.medium, this.large);
}
