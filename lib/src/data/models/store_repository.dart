import 'package:cloud_firestore/cloud_firestore.dart';

class StoreResponseRepository {
  final String id;
  final String address;
  final String imgUrl;
  final Coordinate coordinate;
  final String district;

  StoreResponseRepository(
      this.id, this.address, this.district, this.imgUrl, this.coordinate);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "address": address,
      "district": district,
      "imgUrl": imgUrl,
      "coordinate": coordinate,
    };
  }

  static StoreResponseRepository fromJson(Map<String, Object> json) {
    return StoreResponseRepository(
      json["id"] as String,
      json["address"] as String,
      json["district"] as String,
      json["imgUrl"] as String,
      json["coordinate"] as Coordinate,
    );
  }

  static StoreResponseRepository fromSnapShot(DocumentSnapshot snapshot) {
    try {
      return StoreResponseRepository(
        snapshot.documentID,
        snapshot.data['address'],
        snapshot.data['district'],
        snapshot.data['imgUrl'],
        snapshot.data['coordinate'],
      );
    } catch (ex) {
      return StoreResponseRepository(
          'ID', '0000000000', '000000', 'imgUrl', Coordinate(0.002, 1));
    }
  }
}

class Coordinate {
  final double latitude;
  final double longtitude;

  Coordinate(this.latitude, this.longtitude);
}
