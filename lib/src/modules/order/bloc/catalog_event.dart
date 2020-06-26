import 'package:equatable/equatable.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/models/product_repository.dart';

class GetCatalogEvent extends BaseEvent {
  final List<ProductResponseRepository> products;

  GetCatalogEvent(this.products);

  List<Object> get props => [products];
}
