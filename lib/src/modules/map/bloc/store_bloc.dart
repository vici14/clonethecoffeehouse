import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/store/store_service.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/store/store_service_impl.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_event.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_state.dart';

class StoreBloc extends BlocBase<BaseEvent, StoreState> {
  StoreService _service = StoreServiceImpl();

  @override
  StoreState get initialState => StoreState(isLoading: true);

  @override
  Stream<StoreState> mapEventToState(BaseEvent event) async* {
    if (event is GetStoreEvent) {
      yield* _getStoresState(event);
    }
  }

  Stream<StoreState> _getStoresState(GetStoreEvent event) async* {
    yield StoreState(state: state, isLoading: true);
    var _stores = await _getStores();
    yield StoreState(state: state, isLoading: false, stores: _stores);
  }

  Future<List<StoreEntity>> _getStores() async {
    try {
      return await _service?.getStores();
    } catch (ex) {
      debugPrint('getProducts: ${ex.toString()}');
    }
  }

  getStores() {
    add(GetStoreEvent());
  }
}
