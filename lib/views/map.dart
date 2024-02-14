

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
   LatLng currentLocation = const LatLng(-12.5730816,-38.9087232);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:GoogleMap(initialCameraPosition: CameraPosition(target: currentLocation,)),/*latitude*/ /*longitude*/
          
          
        
    );
  }
}
