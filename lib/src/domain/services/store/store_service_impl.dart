import 'package:flutterclonethecoffeehouse/src/data/repository/stores_repository.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/stores_repository_impl.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';
import 'package:flutterclonethecoffeehouse/src/domain/services/store/store_service.dart';

class StoreServiceImpl implements StoreService {
  StoresRepository _storesRepository = StoresRepositoryImp();

  @override
  Future<List<StoreEntity>> getStores() async {
    return (await _storesRepository?.getStores())
        ?.map((s) => StoreEntity.fromResponse(s))
        ?.toList();
  }
}
