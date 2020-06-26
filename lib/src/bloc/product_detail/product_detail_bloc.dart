import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';

class ProductDetailBloc extends BlocBase<BaseEvent, ProductDetailState> {
  final Size size;

  ProductDetailBloc({this.size});

  @override
  ProductDetailState get initialState => ProductDetailState(quantity: 1);

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

  Stream<ProductDetailState> _incrementQuantityProductState(
      IncrementQuantityProductEvent event) async* {
    yield ProductDetailState(quantity: state.quantity);
    incrementQuantity(state.quantity);
    yield ProductDetailState(quantity: state.quantity);
  }

  Stream<ProductDetailState> _decrementQuantityProductState(
      DecrementQuantityProductEvent event) async* {
    yield ProductDetailState(quantity: state.quantity);
    decrementQuantity(state.quantity);
    yield ProductDetailState(quantity: state.quantity);
  }

  Stream<ProductDetailState> _chooseSizeProductState(ChooseSizeProductEvent event) async* {
    yield ProductDetailState();

    yield ProductDetailState();
  }

  Stream<ProductDetailState> _chooseToppingProductState(
      ChooseToppingProductEvent event) async* {
    yield ProductDetailState();

    /// do service
    yield ProductDetailState();
  }

  incrementQuantity(int currentQuantity) {
    return currentQuantity++;
  }

  decrementQuantity(int currentQuantity) {
    if (currentQuantity > 1) {
      currentQuantity--;
    }
  }

  chooseSize(int sizeCost) {
    switch (size) {
      case Size.LARGE:
        sizeCost = 10000;
        state.isActive = true;
        break;
      case Size.MEDIUM:
        sizeCost = 5000;
        break;
      case Size.SMALL:
        sizeCost = 0;
        break;
    }
    return sizeCost;
  }

  chooseTopping(int toppingCost) {}

  totalCost(int sizeCost, int toppingCost, int quantity, productCost) {
    return (productCost * quantity) + sizeCost + toppingCost;
  }
}
