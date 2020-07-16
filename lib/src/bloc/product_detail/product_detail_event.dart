import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';

class ChooseSizeProductEvent extends BaseEvent {
  final int sizeCost;

  ChooseSizeProductEvent({this.sizeCost});
}

class ChooseToppingProductEvent extends BaseEvent {
  final int toppingCost;

  ChooseToppingProductEvent({this.toppingCost});
}

class IncrementQuantityProductEvent extends BaseEvent {
  final int quantity;

  IncrementQuantityProductEvent({this.quantity});
}

class DecrementQuantityProductEvent extends BaseEvent {
  final int quantity;

  DecrementQuantityProductEvent({this.quantity});
}

class AddProductToCartEvent extends BaseEvent {}
