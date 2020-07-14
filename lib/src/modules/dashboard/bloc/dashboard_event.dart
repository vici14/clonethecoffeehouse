import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';

class PageTappedEvent extends BaseEvent {
  final int index;

  PageTappedEvent({@required this.index});
}
