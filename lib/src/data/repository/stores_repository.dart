import 'package:flutterclonethecoffeehouse/src/data/models/store_repository.dart';

abstract class StoresRepository {
  Future<List<StoreResponseRepository>> getStores();
}
