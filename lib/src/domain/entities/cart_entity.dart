import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/product_detail/product_detail_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';

class CartEntity {
  List<CartItemEntity> listCartItem;

  CartEntity({this.listCartItem});
}

class CartItemEntity {
  ProductEntity product;
  int quantity;
  int cost;
  Size size;
  Topping topping;
}
