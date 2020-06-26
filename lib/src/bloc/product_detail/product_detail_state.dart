import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/product_repository.dart';

enum Size { SMALL, MEDIUM, LARGE }

class ProductDetailState extends BaseState {
  final ProductResponseRepository product;
  int quantity;
  bool isActive;

  ProductDetailState({
    ProductResponseRepository product,
    ProductDetailState state,
    this.isActive,
    this.quantity,
  })  : product = product ?? state?.product,
        super(timeStamp: DateTime.now().millisecondsSinceEpoch);
}
