import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/cart_entity.dart';

class AddProductEvent extends BaseEvent {
  final CartItemEntity cartItem;

  AddProductEvent({this.cartItem});
}

class UpdateProductEvent extends BaseEvent {}

class UpdateCartEvent extends BaseEvent {
  final List<ProductEntity> products;
  final int totalCost;

  UpdateCartEvent(this.products, this.totalCost);
}
