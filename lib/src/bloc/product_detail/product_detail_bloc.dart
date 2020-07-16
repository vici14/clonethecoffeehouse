import 'package:flutter/rendering.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';

class ProductDetailBloc extends BlocBase<BaseEvent, ProductDetailState> {
  final ProductEntity product;
  final Size size;
  final Topping topping;

  ProductDetailBloc({
    this.product,
    this.size,
    this.topping,
  });

  @override
  ProductDetailState get initialState => ProductDetailState(
        product: product,
        isActive: false,
        quantity: 1,
        selectedSizeIndex: -1,
        sizeCost: 0,
        toppingCost: 0,
        state: state,
      );

  @override
  Stream<ProductDetailState> mapEventToState(BaseEvent event) async* {
    if (event is IncrementQuantityProductEvent) {
      yield* _incrementQuantityProductState(event);
    } else if (event is DecrementQuantityProductEvent) {
      yield* _decrementQuantityProductState(event);
    } else if (event is ChooseSizeProductEvent) {
      yield* _chooseSizeProductState(event);
    } else if (event is ChooseToppingProductEvent) {
      yield* _chooseToppingProductState(event);
    }
  }

  Stream<ProductDetailState> _incrementQuantityProductState(IncrementQuantityProductEvent event) async* {
    var _quantity = state.quantity + 1;
    yield ProductDetailState(
      state: state,
      quantity: _quantity,
    );
  }

  Stream<ProductDetailState> _decrementQuantityProductState(DecrementQuantityProductEvent event) async* {
    var _quantity;
    if (state.quantity > 1) {
      _quantity = state.quantity - 1;
    }
    yield ProductDetailState(
      state: state,
      quantity: _quantity,
    );
  }

  Stream<ProductDetailState> _chooseSizeProductState(ChooseSizeProductEvent event) async* {
    yield ProductDetailState(state: state, sizeCost: event.sizeCost);
  }

  Stream<ProductDetailState> _chooseToppingProductState(ChooseToppingProductEvent event) async* {
    yield ProductDetailState(state: state, toppingCost: event.toppingCost);
  }

  incrementQuantity() {
    add(IncrementQuantityProductEvent());
  }

  decrementQuantity() {
    add(DecrementQuantityProductEvent());
  }

  int _chooseSize(Size size) {
    switch (size) {
      case Size.LARGE:
        return state.sizeCost = 10000;
      case Size.MEDIUM:
        return state.sizeCost = 5000;
      case Size.SMALL:
        return state.sizeCost = 0;
    }
    return state.sizeCost;
  }

  chooseSize(Size size) {
    add(ChooseSizeProductEvent(sizeCost: _chooseSize(size)));
  }

  int _chooseTopping(Topping topping) {
    switch (topping) {
      case Topping.TRANCHAUTRANG:
        return state.toppingCost = 10000;
      case Topping.NONE:
        return state.toppingCost = 0;
    }
    return state.toppingCost;
  }

  chooseTopping(Topping topping) {
    add(ChooseToppingProductEvent(toppingCost: _chooseTopping(topping)));
  }

  totalCost() {
    return (state.product.cost + state.sizeCost + state.toppingCost) * state.quantity;
  }
}
