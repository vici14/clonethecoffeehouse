import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/cart_entity.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_event.dart';
import 'package:flutterclonethecoffeehouse/src/modules/cart/bloc/cart_state.dart';

class CartBloc extends BlocBase<BaseEvent, CartState> {
  @override
  CartState get initialState => CartState(
        cart: CartEntity(
          listCartItem: [],
        ),
        totalQuantity: 0,
        totalCost: 0,
        isLoading: true,
        state: state,
      );

  @override
  Stream<CartState> mapEventToState(BaseEvent event) async* {
    if (event is UpdateProductEvent) {
      yield* _updateProductState(event);
    } else if (event is AddProductEvent) {
      yield* _addProductState(event);
    }
  }

  Stream<CartState> _updateProductState(UpdateProductEvent event) async* {}

  Stream<CartState> _addProductState(AddProductEvent event) async* {
    var item = event.cartItem;
    yield CartState(state: state, isLoading: true);
    CartItemEntity cartItem = CartItemEntity();
    cartItem = _createCartItem(
      product: item.product,
      quantity: item.quantity,
      cost: item.cost,
      size: item.size,
      topping: item.topping,
    );
//    if(cart.listItem.contains(_item)){
//      cart.
//    }
    if (state.cart.listCartItem == null) {
      state.cart.listCartItem = [];
    }

    state.cart.listCartItem.add(cartItem);
    state.totalQuantity += cartItem.quantity;
    state.totalCost += cartItem.cost;
    yield CartState(state: state, isLoading: false, cart: state.cart);
  }

  CartItemEntity _createCartItem({
    @required ProductEntity product,
    int quantity,
    int cost,
    Size size,
    Topping topping,
  }) {
    CartItemEntity item = CartItemEntity();
    item.product = product;
    item.size = size;
    item.topping = topping;
    item.quantity = quantity;
    item.cost = cost;
    return item;
  }

  addProduct({
    ProductEntity product,
    int quantity,
    int cost,
    Size size,
    Topping topping,
  }) {
    add(
      AddProductEvent(
        cartItem: _createCartItem(
          product: product,
          topping: topping,
          cost: cost,
          size: size,
          quantity: quantity,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    print("Cart Bloc Closing...");
    return super.close();
  }
}
