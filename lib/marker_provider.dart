import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MarkerProvider with ChangeNotifier {
  List<LatLng> _points = [];

  List<LatLng> get points => _points;

  void updateMarker(int index, LatLng newPoint) {
    _points[index] = newPoint;
    notifyListeners();
  }

  void addMarker(LatLng point) {
    _points.add(point);
    notifyListeners();
  }
}