import 'dart:async';
import 'package:env_app/models/pin_data.dart';
import 'package:env_app/utilities/theme.dart';
import 'package:env_app/widgets/marker_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController _controller;
  Position position;

  Widget _child = Center(
    child: Text('Loading...'),
  );
  BitmapDescriptor _sourceIcon;

  MapType _currentMapType = MapType.normal;

  double _pinPillPosition = -500;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  PinData _sourcePinInfo;

  void _setSourceIcon() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/pin.png');
  }

  Future<void> getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
    await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('Access denied');
        break;
      case GeolocationStatus.disabled:
        showToast('Disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('Unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Accesss Granted');
        _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(position.latitude, position.longitude),
          icon: _sourceIcon,
          onTap: () {
            setState(() {
              _currentPinData = _sourcePinInfo;
              _pinPillPosition = 0;
            });
          })
    ].toSet();
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getPermission();
    _setSourceIcon();
    super.initState();
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 12.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _setStyle(controller);
        _setMapPins();
      },
      tiltGesturesEnabled: false,
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -500;
        });
      },
    );
  }

  void _setMapPins() {
    _sourcePinInfo = PinData(
        pinPath: 'assets/pin.png',
        locationName: "My Location",
        location: LatLng(position.latitude, position.longitude),
        avatarPath: "assets/driver.jpg",
        labelColor: Colors.blue);
  }

  _onMapTypeButtonPressed(){
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType;
    });
  }

  void _onAddPinButtonPressed() {
    _sourcePinInfo = PinData(
        pinPath: 'assets/pin.png',
        locationName: "My Location",
        location: LatLng(position.latitude, position.longitude),
        avatarPath: "assets/driver.jpg",
        labelColor: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _child,
            AnimatedPositioned(
              bottom: _pinPillPosition,
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildAvatar(),
                      _buildLocationInfo(),
                      //new MarkerInfo(_currentPinData),
                      _buildMarkerType()
                    ],
                  ),
                ),
              ),
            ),
              Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
              alignment: Alignment.topRight,
              child: Column(
              children: <Widget>[
              button(_onMapTypeButtonPressed, Icons.map),
              SizedBox(height: 16.0,),
              button(_onAddPinButtonPressed, Icons.add_location),

              ],
              ),
              ),
              ),
          ],
        ));
  }

  Widget _buildAvatar() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: 50,
      height: 50,
      child: ClipOval(
        child: Image.asset(
          _currentPinData.avatarPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget button(Function function, IconData icon){
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon
      )
    );
  }


  Widget _buildLocationInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentPinData.locationName,
              style: CustomAppTheme().data.textTheme.subtitle,
            ),
            Text(
              'Latitude : ${_currentPinData.location.latitude}',
              style: CustomAppTheme().data.textTheme.display1,
            ),
            Text(
              'Longitude : ${_currentPinData.location.longitude}',
              style: CustomAppTheme().data.textTheme.display1,
            )
          ],
        ),
      ),
    );
  }


  Widget _buildMarkerType() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Image.asset(
        _currentPinData.pinPath,
        width: 50,
        height: 50,
      ),
    );
  }
}


  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    button(_onMapTypeButtonPressed, Icons.map, "mapChanger"),
                    SizedBox(height: 16.0,),
                    button(_createMarker, Icons.add_location, "markerAdder"),

                  ],
                ),
              ),
            )
            
          ],
          
        ),


    );
  }


  Future<String> initPlatform() async {
    Map<String, double> myCurrentLocation;
    try {
      myCurrentLocation = await location.getLocation();
    } on
    PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        error = "PERMISSION_DENIED";
      }
      else if (e.code == "PERMISSION_DENIED_NEVER_ASK") {
        error = "Never Ask";
      }
      myCurrentLocation = null;
    }
    setState(() {
      currentLocation = myCurrentLocation;
    });
    final coordinates = Coordinates(currentLocation['latitude'], currentLocation['longitude']);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    cityText = first.adminArea;
    return cityText;
  }
}*/

