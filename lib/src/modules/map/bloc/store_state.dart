import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';

class StoreState extends BaseState {
  final List<StoreEntity> stores;

  StoreState({List<StoreEntity> stores, StoreState state, bool isLoading})
      : stores = stores ?? state?.stores,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecond);
}
