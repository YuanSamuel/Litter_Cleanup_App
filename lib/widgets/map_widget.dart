import 'dart:async';
import 'package:env_app/models/pin_data.dart';
import 'package:env_app/utilities/constants.dart';
import 'package:env_app/utilities/theme.dart';
import 'package:env_app/widgets/marker_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:env_app/screens/location_accepted.dart';
import 'package:env_app/screens/camera.dart';

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

  Set<Marker> markers = {};

  double _pinPillPosition = -800;
  double _pinPillPosition2 = -800;

  double zoomAmt = 12.0;

  List<LatLng> samplePositions = [LatLng(35, -100), LatLng(0, 0), LatLng(10, -80)];

  int markerCount = 0;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: LatLng(31.553896, -97.119940),
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
        showToast('Access Granted');
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

  /*
   _getPosition() async{
    Position current = await Geolocator().getCurrentPosition();
  }*/

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  void _createMarker() {
    setState(() {
      markerCount++;
      markers.add(Marker(
          markerId: MarkerId(markerCount.toString()),
          position: LatLng(position.latitude, position.longitude),
          icon: _sourceIcon,
          onTap: () {
            setState(() {
              _currentPinData = _sourcePinInfo;
              _pinPillPosition = 0;
            });
          }));
    });
  }

  void _generateSampleMarkers(){
    for(LatLng pos in samplePositions){
      setState(() {
        markerCount++;
        markers.add(Marker(
            markerId: MarkerId(markerCount.toString()),
            position: LatLng(pos.latitude, pos.longitude),
            icon: _sourceIcon,
            onTap: () {
              setState(() {
                _currentPinData = _sourcePinInfo;
                _pinPillPosition = 0;
              });
            }));
      });
      print(markerCount);
    }
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
      zoomGesturesEnabled: true,
      mapType: MapType.normal,
      markers: markers,
      initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: zoomAmt),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _setStyle(controller);
        _setMapPins();
      },
      tiltGesturesEnabled: false,
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -800;
          _pinPillPosition2 = -800;
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

  _onAddPinButtonPressed() {
    setState(() {
      _getCurrentLocation();
      _pinPillPosition2 = 0;
      _sourcePinInfo = PinData(
          pinPath: 'assets/pin.png',
          locationName: "My Location",
          location: LatLng(position.latitude, position.longitude),
          avatarPath: "assets/driver.jpg",
          labelColor: Colors.blue);
    });
  }

  _onSubmitMarker(){
    setState(() {
      _getCurrentLocation();
      _pinPillPosition2 = -800;
      _createMarker();
    });
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
                  margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  height: 500,
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
                      //_buildAvatar(),
                      _buildLocationInfo(),
                      //new MarkerInfo(_currentPinData),
                      _buildMarkerType()
                    ],
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              bottom: _pinPillPosition2,
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 500,
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
                      _buildPinCreate(),
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
                  SizedBox(height: 16.0,),
                  button(_zoomIn, Icons.zoom_in),
                  SizedBox(height: 16.0,),
                  button(_zoomOut, Icons.zoom_out),

              ],
              ),
              ),
              ),
          ],
        ));
  }

  void _zoomIn(){
    setState(() {
      zoomAmt++;
      CameraPosition(zoom: zoomAmt);
    });
  }
  void _zoomOut(){
    setState(() {
      zoomAmt--;
      CameraPosition(zoom: zoomAmt);
    });
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Image(image: AssetImage('assets/messy1.JPG'),),
            ),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Baylor University',
                style: medBlackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
                child: Text(
                  'Table is messy, needs some help cleaning. Requires 3 - 4 people',
                  style: smallBlackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'WacodeHackAdmin',
                style: smallGreyText,
              ),
            ),
            RaisedButton(
              child: Text('Accept Challenge'),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationAccepted())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCreate(){
    //_pinPillPosition2 = 0;
    return Expanded(
        child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image(image: AssetImage('assets/messy1.JPG'),),
                PhotoPage(),
                Container(
                    alignment: Alignment.centerLeft,
                    //decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Comments',
                        hintStyle: kHintTextStyleBlack,
                      ),
                    )
                ),
              RaisedButton(
              child: Text('Submit'),
                onPressed: _onSubmitMarker,
              ),
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




