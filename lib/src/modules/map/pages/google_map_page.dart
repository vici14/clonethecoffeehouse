import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_bloc.dart';
import 'package:flutterclonethecoffeehouse/src/modules/map/bloc/store_state.dart';
import 'package:geolocator/geolocator.dart';
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
  static LatLng _initialPosition;
  static LatLng _lastMapPosition = _initialPosition;
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
//    setCustomMyIcon();
    _getUserLocation();
    drawAllMarkers();
//    myMarkers.add(Marker(
//      markerId: MarkerId("00"),
//      position: LatLng(10.782595, 106.680088),
//    ));
  }

  void initMarker(request, requestID) {
    var markerIdVal = requestID;
    final MarkerId markerId = MarkerId(markerIdVal);

    ///createing a new Marker
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            request['location'].latitude, request['location'].longtitude),
        infoWindow:
            InfoWindow(title: "Fetched Markers", snippet: request['address']));
    setState(() {
      _markers[markerId] = marker;
      print(markerId);
    });
  }

  drawAllMarkers() {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, StoreState state) {
        if (state.stores.isNotEmpty) {
          for (var i = 0; i < state.stores.length; i++) {
            initMarker(state.stores[i].coordinate, state.stores[i].id);
          }
        }
      },
    );
  }

//  void setCustomMyIcon() async {
//    myIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(devicePixelRatio: 2.5), UIData.icShip);
//  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('aaa${placemark[0].name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    var mapWidth = MediaQuery.of(context).size.width;
    var mapHeight = MediaQuery.of(context).size.height * 0.92;
    double iconSize = 40.0;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
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
                        print('storelength222 ${state?.stores?.length}');
                        Marker resultMarker = Marker(
                            icon: myIcon,
                            markerId: MarkerId(state.stores[i].id.toString()),
                            position: LatLng(
                                state.stores[i].coordinate.latitude,
                                state.stores[i].coordinate.longtitude));
                        print(
                            '11111${state.stores[i].coordinate.latitude},${state
                                .stores[i].coordinate.longtitude}');
                        myMarkers.add(resultMarker);
                      }
                    }
                    return Container(
                      width: mapWidth,
                      height: mapHeight,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        buildingsEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: true,
                        scrollGesturesEnabled: true,
                        initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 13),
                        markers: Set.of(myMarkers),
                        onCameraMove: (CameraPosition position) {
                          findCenterPosition(position);
                          findClosestMarker(position);
                          print(position);
                          print(findClosestMarker(position));
                        },
                      ),
                    );
                  }),
              Positioned(
                top: (mapHeight - iconSize) / 2,
                right: (mapWidth - iconSize) / 2,
                child: new Icon(Icons.person_pin_circle,
                    color: Theme
                        .of(context)
                        .primaryColor, size: iconSize),
              )
            ],
          )
        ],
      ),
    );
  }

//
  void _onMapCreated(GoogleMapController controller) async {
    var INITIAL_LOCATION = _initialPosition;
    _mapController.complete(controller);
    if ([INITIAL_LOCATION] != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = INITIAL_LOCATION;
      Marker marker = Marker(
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        markerId: markerId,
        position: position,
        draggable: false,
      );

//      setState(() {
//        _markers[markerId] = marker;
//      });

      Future.delayed(Duration(milliseconds: 200), () async {
        GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 16.0,
            ),
          ),
        );
      });
    }
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
    print('RESULT ${myMarkers[closest].markerId}');
  }

  rad(x) {
    return x * Math.pi / 180;
  }
}
