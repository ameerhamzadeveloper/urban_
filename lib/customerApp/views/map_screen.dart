import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234,67.062513);

  LatLng initPostition = latLng;

  onCameraMove(CameraPosition position){
    initPostition = position.target;
  }
  onMapCreated (GoogleMapController controller) {
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            height: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition:
                    CameraPosition(target: latLng, zoom: 11.0),
                    onCameraMove: onCameraMove,
                    onMapCreated: onMapCreated,
                    mapType: MapType.normal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        color: Colors.black,
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Book Service",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}