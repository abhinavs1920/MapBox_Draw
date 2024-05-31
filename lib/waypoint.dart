import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untitled/resource.dart';

class WaypointPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<WaypointPage> {
  final MapController mapController = MapController();
  List<LatLng> points = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Flight Area'),
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(51.5, -0.09),
                zoom: 13.0,
                onTap: (tapPosition,latlng) {
                  setState(() {
                    points.add(latlng);
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/abhinavs1920/clw6brkxu02py01qpa24wfkie/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWJoaW5hdnMxOTIwIiwiYSI6ImNsdzZhcTB0ZDFqaTEya2xjMzZyemVqbTMifQ.bncVi5B-ctz2Px7Cn2hm0w',
                  additionalOptions: {
                    'accessToken': 'pk.eyJ1IjoiYWJoaW5hdnMxOTIwIiwiYSI6ImNsdzZhcTB0ZDFqaTEya2xjMzZyemVqbTMifQ.bncVi5B-ctz2Px7Cn2hm0w',
                    'id': 'mapbox.mapbox-streets-v8',
                  },
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      strokeWidth: 2.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: points.map((point) {
                    return Marker(
                      width: 10.0,
                      height: 10.0,
                      point: point,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}