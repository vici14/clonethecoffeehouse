import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/domain/entities/store_entity.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_state.dart';
import 'package:flutterclonethecoffeehouse/src/utils/uidata.dart';
import 'package:flutterclonethecoffeehouse/src/widgets/stateful/list_stores.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  State<GoogleMapPage> createState() {
    return _GoogleMapPageState();
  }
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  StoreBloc bloc;

  _GoogleMapPageState() {
    bloc = StoreBloc();
    bloc.getStores();
  }

  List<StoreEntity> updatedStore = [];
  CameraPosition lastLocation =
      CameraPosition(target: LatLng(10.782595, 106.680088));
  GoogleMapController mapController;
  List<Marker> myMarkers = [];
  static BitmapDescriptor myIcon;
  List<DistanceMarker> distanceMarkers = [];
  List<DistanceMarker> updatedList = [];

  static final CameraPosition _tchRBB = CameraPosition(
    target: LatLng(10.782595, 106.680088),
    bearing: 15.0,
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    setCustomMyIcon();
  }

  void setCustomMyIcon() async {
    myIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(40, 40)), UIData.icCoffee);
  }

  @override
  Widget build(BuildContext context) {
    var mapWidth = MediaQuery.of(context).size.width;
    var mapHeight = MediaQuery.of(context).size.height * 0.92 - 57;
    double iconSize = 40.0;
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: <Widget>[
            BlocBuilder(
                bloc: bloc,
                builder: (BuildContext context, StoreState state) {
                  if (state.isLoading == true) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (myMarkers.isEmpty) {
                    for (var i = 0; i < state.stores.length; i++) {
                      var store = state.stores[i];
                      Marker resultMarker = Marker(
                          icon: myIcon,
                          markerId: MarkerId(store.id.toString()),
                          infoWindow: InfoWindow(
                              title: store.address,
                              snippet: 'Quận ${store.district}'),
                          position: LatLng(store.coordinate.latitude,
                              store.coordinate.longtitude));
                      myMarkers.add(resultMarker);
                    }
                  }

                  return Stack(
                    children: <Widget>[
                      Container(
                        width: mapWidth,
                        height: mapHeight,
                        child: GoogleMap(
                          onMapCreated: (controller) =>
                              mapController = controller,
                          myLocationEnabled: true,
                          buildingsEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          myLocationButtonEnabled: true,
                          scrollGesturesEnabled: true,
                          initialCameraPosition: _tchRBB,
                          markers: Set.of(myMarkers),
                          onCameraIdle: () {
                            List<StoreEntity> queryStore = [];
                            updatedList =
                                findFiveClosestStore(lastLocation, myMarkers);
                            for (var i = 0; i < updatedList.length; i++) {
                              for (var j = 0; j < state.stores.length; j++) {
                                if (updatedList[i].markerId.value ==
                                    state.stores[j].id) {
                                  queryStore.add(state.stores[j]);
                                }
                              }
                              setState(() {
                                updatedStore = queryStore;
                              });
                            }
                            return updatedStore;
                          },
                          onCameraMove: (CameraPosition position) {
                            lastLocation = position;
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: ListStore(
                          stores: updatedStore,
                        ),
                      ),
                      Positioned(
                        top: (mapHeight - iconSize) / 2,
                        right: (mapWidth - iconSize) / 2,
                        child: new Icon(Icons.person_pin_circle,
                            color: Theme.of(context).primaryColor,
                            size: iconSize),
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  List<DistanceMarker> findFiveClosestStore(CameraPosition lastLocation, List<Marker> markers) {
    List<DistanceMarker> list = [];
    var cameraLat = lastLocation?.target?.latitude;
    var cameraLong = lastLocation?.target?.longitude;
    var R = 6371; // radius of earth in km
    var distances = [];
    for (var i = 0; i < markers.length; i++) {
      var markerLat = markers[i]?.position?.latitude;
      var markerLong = markers[i]?.position?.longitude;
      var distanceLat = rad(markerLat - cameraLat);
      var distanceLong = rad(markerLong - cameraLong);
      var a = Math.sin(distanceLat / 2) * Math.sin(distanceLat / 2) + Math.cos(rad(cameraLat)) * Math.cos(rad(cameraLat)) * Math.sin(distanceLong / 2) * Math.sin(distanceLong / 2);
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      var d = R * c;
      distances.add(d);

      DistanceMarker resultMarker = DistanceMarker(markers[i].markerId, distances[i]);

      list.add(resultMarker);
    }
    list.sort((a, b) => a?.distance?.compareTo(b?.distance));
//    list = list.take(3).toList();

    List<DistanceMarker> updateList = [];
    int max = (list.length > 5) ? 5 : list.length;
    for (var i = 0; i < max; i++) {
      updateList.add(list[i]);
    }

    return updateList;
  }

  rad(x) {
    return x * Math.pi / 180;
  }
}

class DistanceMarker {
  final MarkerId markerId;
  final double distance;

  DistanceMarker(this.markerId, this.distance);
}
