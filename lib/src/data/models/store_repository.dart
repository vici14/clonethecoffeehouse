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

  static StoreResponseRepository fromJson(
      {String id, Map<String, Object> json}) {
    return StoreResponseRepository(
        id,
        json["address"] as String,
        json["district"] as String,
        json["imgUrl"] as String,
        Coordinate.fromJson(json["coordinate"]));
  }
//  static StoreResponseRepository fromSnapshot(DocumentSnapshot snap)
}

class Coordinate {
  final double latitude;
  final double longtitude;

  Coordinate(this.latitude, this.longtitude);

  Map<String, Object> toJson() {
    return {
      "lat": latitude,
      "lng": longtitude,
    };
  }

  static Coordinate fromJson(Map<String, Object> json) {
    return Coordinate(
      json["lat"] as double,
      json["lng"] as double,
    );
  }
}
