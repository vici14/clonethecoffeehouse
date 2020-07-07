import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  GoogleMapController mapController;
  List<Marker> myMarkers = [];
  Completer<GoogleMapController> _mapController = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  static BitmapDescriptor myIcon;
  List<Marker> updatedList = [];

  static final CameraPosition _tchRBB = CameraPosition(
    target: LatLng(10.782595, 106.680088),
    bearing: 15.0,
    zoom: 18,
  );

  @override
  void initState() {
    super.initState();
    setCustomMyIcon();
//    drawAllMarkers();
  }

//  void initMarker(request, requestID) {
//    var markerIdVal = requestID;
//    final MarkerId markerId = MarkerId(markerIdVal);
//
//    ///createing a new Marker
//    final Marker marker = Marker(
//        markerId: markerId,
//        position: LatLng(
//            request['location'].latitude, request['location'].longtitude),
//        infoWindow:
//            InfoWindow(title: "Fetched Markers", snippet: request['address']));
//    setState(() {
//      _markers[markerId] = marker;
//      print(markerId);
//    });
//  }
//
//  drawAllMarkers() {
//    return BlocBuilder(
//      bloc: bloc,
//      builder: (BuildContext context, StoreState state) {
//        if (state.stores.isNotEmpty) {
//          for (var i = 0; i < state.stores.length; i++) {
//            initMarker(state.stores[i].coordinate, state.stores[i].id);
//          }
//
//        }
//        return Container();
//      },
//    );
//  }

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
                  print('storelength ${state?.stores?.length}');
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
                          onCameraMove: (CameraPosition position) {
                            findCenterPosition(position);
                            findClosestMarker(position);
//                          print(position);
//                          print(findClosestMarker(position));
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: ListStore(
                          stores: state.stores,
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

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  findCenterPosition(CameraPosition cameraPosition) {
    if (_markers.length > 0) {
      MarkerId markerId = MarkerId(_markerIdVal());
      Marker marker = _markers[markerId];
      Marker updatedMarker = marker.copyWith(
        positionParam: cameraPosition.target,
      );
    }
  }

  findClosestMarker(CameraPosition cameraPosition) {
    var cameraLat = cameraPosition?.target?.latitude;
    var cameraLong = cameraPosition?.target?.longitude;
    var R = 6371; // radius of earth in km
    var distances = [];
    var closest = -1;
    for (var i = 0; i < myMarkers.length; i++) {
      var markerLat = myMarkers[i].position.latitude;
      var markerLong = myMarkers[i].position.longitude;
      var distanceLat = rad(markerLat - cameraLat);
      var distanceLong = rad(markerLong - cameraLong);
      var a = Math.sin(distanceLat / 2) * Math.sin(distanceLat / 2) +
          Math.cos(rad(cameraLat)) *
              Math.cos(rad(cameraLat)) *
              Math.sin(distanceLong / 2) *
              Math.sin(distanceLong / 2);
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      var d = R * c;
      distances.add(d);
      if (closest == -1 || d < distances[closest]) {
        closest = i;

        /// minimum distance
      }
    }
    print('RESULT ${myMarkers[closest].position.latitude}');
  }

  rad(x) {
    return x * Math.pi / 180;
  }
}
