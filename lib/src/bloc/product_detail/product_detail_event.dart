import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/models/product_repository.dart';

class ChooseSizeProductEvent extends BaseEvent {}

class ChooseToppingProductEvent extends BaseEvent {}

class IncrementQuantityProductEvent extends BaseEvent {
//  final List<ProductRepository> products;
//
//  IncrementQuantityProductEvent(this.products);
//
//  List<Object> get props => [products];
}

class DecrementQuantityProductEvent extends BaseEvent {}
