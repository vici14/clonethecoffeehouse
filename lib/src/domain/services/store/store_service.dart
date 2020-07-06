import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';

abstract class StoreService {
  Future<List<StoreEntity>> getStores() {}
}
