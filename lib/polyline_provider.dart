import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class PolylineProvider with ChangeNotifier {
  List<List<LatLng>> polylines = [];
  List<LatLng> currentPolyline = [];

  void addPoint(LatLng point) {
    currentPolyline.add(point);
    notifyListeners();
  }

  void finishPolyline() {
    if (currentPolyline.isNotEmpty) {
      polylines.add(currentPolyline);
      currentPolyline = [];
      notifyListeners();
    }
  }

  void resetCurrentPolyline() {
    currentPolyline = [];
    notifyListeners();
  }
}
