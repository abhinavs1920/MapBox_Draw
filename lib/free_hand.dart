import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'polyline_provider.dart';
import 'package:untitled/resource.dart';

class FreehandPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<FreehandPage> {
  final MapController mapController = MapController();
  int pointerCount = 0;

  LatLng getLatLng(Offset localPosition) {
    final bounds = mapController.camera.visibleBounds;
    final size = MediaQuery.of(context).size;
    final double xRatio = localPosition.dx / size.width;
    final double yRatio = localPosition.dy / size.height;

    final double boundsHeight = bounds.north - bounds.south;
    final double boundsWidth = bounds.east - bounds.west;

    final double lat = bounds.north - (boundsHeight * yRatio);
    final double lng = bounds.west + (boundsWidth * xRatio);

    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Flight Area'),
          leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.arrow_back,
              size: 24,
            ),
          ),
        ),
        body: Listener(
          onPointerDown: (details) {
            setState(() {
              pointerCount++;
            });
          },
          onPointerUp: (details) {
            setState(() {
              pointerCount--;
              if (pointerCount == 0) {
                Provider.of<PolylineProvider>(context, listen: false).finishPolyline();
              }
            });
          },
          onPointerMove: (details) {
            if (pointerCount == 1) {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              Offset localPosition = renderBox.globalToLocal(details.position);
              LatLng latLng = getLatLng(localPosition);
              Provider.of<PolylineProvider>(context, listen: false).addPoint(latLng);
            }
          },
          child: Consumer<PolylineProvider>(
            builder: (context, polylineProvider, child) {
              return Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: LatLng(51.5, -0.09),
                      zoom: 13.0,
                      interactionOptions: InteractionOptions(
                        flags: pointerCount > 1
                            ? InteractiveFlag.all
                            : InteractiveFlag.all &
                        ~InteractiveFlag.pinchZoom &
                        ~InteractiveFlag.drag,
                      ),
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
                          ...polylineProvider.polylines.map((points) {
                            return Polyline(
                              points: points,
                              color: Colors.blue,
                              strokeWidth: 2.0,

                            );
                          }).toList(),
                          if (polylineProvider.currentPolyline.isNotEmpty)
                            Polyline(
                              points: polylineProvider.currentPolyline,
                              color: Colors.blue,
                              strokeWidth: 2.0,
                            ),
                        ],
                      ),
                      PolygonLayer(
                        polygons: polylineProvider.polylines.map((points) {
                          return Polygon(
                            points: points,
                            color: Colors.deepOrange.withOpacity(0.5),
                            borderColor: Colors.blue.withOpacity(0.3),
                            borderStrokeWidth: 2.0,
                            isFilled: true,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
