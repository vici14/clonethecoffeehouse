import 'package:bloc/bloc.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';

abstract class BlocBase<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {}
