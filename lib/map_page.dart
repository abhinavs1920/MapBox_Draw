import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'marker_provider.dart';

class PolygonPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<PolygonPage> {
  bool isPolygonComplete = false;
  final Distance distance = Distance();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _promptForVertices();
    });
  }

  void _promptForVertices() async {
    Future.delayed(Duration.zero, () async {
      String? vertices = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter number of vertices'),
            content: TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                Navigator.of(context).pop(value);
              },
            ),
          );
        },
      );

      if (vertices != null) {
        _generatePolygon(int.parse(vertices));
      }
    });
  }

  void _generatePolygon(int vertices) {
    LatLng center = LatLng(51.5, -0.09);
    double radius = 0.01;
    for (int i = 0; i < vertices; i++) {
      double angle = (2 * 3.14159 / vertices) * i;
      LatLng point = LatLng(
        center.latitude + radius * cos(angle),
        center.longitude + radius * sin(angle),
      );
      Provider.of<MarkerProvider>(context, listen: false).addMarker(point);
    }

    LatLng centroid = _getCentroid(Provider.of<MarkerProvider>(context, listen: false).points);
    Provider.of<MarkerProvider>(context, listen: false).points.sort((a, b) {
      double angleA = atan2(a.latitude - centroid.latitude, a.longitude - centroid.longitude);
      double angleB = atan2(b.latitude - centroid.latitude, b.longitude - centroid.longitude);
      return angleA.compareTo(angleB);
    });
  }

  LatLng _getCentroid(List<LatLng> points) {
    double latitudeSum = 0, longitudeSum = 0;
    for (LatLng point in points) {
      latitudeSum += point.latitude;
      longitudeSum += point.longitude;
    }
    return LatLng(latitudeSum / points.length, longitudeSum / points.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Flight Area'),
        leading: InkWell(
          onTap: (){

          },
          child: Icon(
            Icons.arrow_back,
            size: 24,
          ),
        ),

      ),
      body: Stack(
        children: [
          FlutterMap(
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
              Consumer<MarkerProvider>(
                builder: (context, markerProvider, child) {
                  return PolygonLayer(
                    polygons: [
                      Polygon(
                        points: markerProvider.points,
                        color: Colors.deepOrange,
                        borderColor: Colors.blue,
                        borderStrokeWidth: 2.0,
                        isFilled: true,
                      ),
                    ],
                  );
                },
              ),
              Consumer<MarkerProvider>(
                builder: (context, markerProvider, child) {
                  return DragMarkers(
                    markers: markerProvider.points.map((point) {
                      return DragMarker(
                        point: point,
                        offset: const Offset(0.0, -8.0),
                        onDragUpdate: (details, latLng) {
                          int index = markerProvider.points.indexWhere((p) => p == point);
                          markerProvider.updateMarker(index, latLng);
                        },
                        builder: (BuildContext context, LatLng pos, bool isDragging) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Marker'),
                                    content: Text('Latitude: ${pos.latitude}\nLongitude: ${pos.longitude}'),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.zoom_out_map, color: Colors.black, size: 28),
                          );
                        },
                        size: Size(40,40),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}