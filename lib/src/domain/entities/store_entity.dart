import 'package:flutterclonethecoffeehouse/src/data/models/store_repository.dart';

class StoreEntity {
  final String id;
  final String address;
  final String district;
  final Coordinate coordinate;
  final String imgUrl;

  String get fullAddress => '${address}, Quận ${district}, Hồ Chí Minh ';
  StoreEntity(
      {this.id, this.address, this.district, this.coordinate, this.imgUrl});

  factory StoreEntity.fromResponse(StoreResponseRepository store) {
    return StoreEntity(
        id: store.id,
        address: store.address,
        district: store.district,
        coordinate: store.coordinate,
        imgUrl: store.imgUrl);
  }
}
