import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/cart_entity.dart';

class CartState extends BaseState {
  final CartEntity cart;
  int totalQuantity;
  int totalCost;

  CartState({
    CartEntity cart,
    CartState state,
    bool isLoading,
    int totalCost,
    int totalQuantity,
  })  : cart = cart ?? state?.cart,
        totalQuantity = totalQuantity ?? state.totalQuantity,
        totalCost = totalCost ?? state.totalCost,
        super(
          isLoading: isLoading ?? state?.isLoading,
          timeStamp: DateTime.now().millisecondsSinceEpoch,
        );
}
