import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untitled/resource.dart';

class CirclePage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<CirclePage> {
  final MapController mapController = MapController();
  double radius = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map with Circle'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://api.mapbox.com/styles/v1/abhinavs1920/clw6brkxu02py01qpa24wfkie/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWJoaW5hdnMxOTIwIiwiYSI6ImNsdzZhcTB0ZDFqaTEya2xjMzZyemVqbTMifQ.bncVi5B-ctz2Px7Cn2hm0w',
                    additionalOptions: {
                      'accessToken': 'pk.eyJ1IjoiYWJoaW5hdnMxOTIwIiwiYSI6ImNsdzZhcTB0ZDFqaTEya2xjMzZyemVqbTMifQ.bncVi5B-ctz2Px7Cn2hm0w',
                      'id': 'mapbox.mapbox-streets-v8',
                    },
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: LatLng(51.5, -0.09),
                        color: Colors.blue.withOpacity(0.7),
                        borderStrokeWidth: 2,
                        useRadiusInMeter: true,
                        radius: radius, // in meters
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Slider(
              min: 10,
              max: 1000,
              divisions: 100,
              value: radius,
              onChanged: (newRadius) {
                setState(() {
                  radius = newRadius;
                });
              },
            ),
            Text('Radius: ${radius.toStringAsFixed(2)} meters'),
          ],
        ),
      ),
    );
  }
}