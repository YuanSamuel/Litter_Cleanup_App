import 'package:env_app/models/pin_data.dart';
import 'package:env_app/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:env_app/utilities/theme.dart';

class MarkerInfo extends StatelessWidget {
  final PinData pinData;

  MarkerInfo(PinData currentPinData, {this.pinData});

  @override
  Widget build(BuildContext context) {
    var _currentPinData = pinData;
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
}

