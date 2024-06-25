# MapBox Custom Map App

This Flutter application utilizes MapBox custom maps and several Flutter packages to implement various map-related features, including freehand drawing.

## Features

- **Custom Maps:** Utilizes MapBox Studio to create and integrate custom maps.
- **Flutter Packages Used:**
  - `flutter_map: ^6.1.0`
  - `flutter_map_tappable_polyline: ^6.0.0`
  - `flutter_map_marker_cluster: ^1.3.6`
  - `flutter_map_dragmarker: ^6.0.0`
  - `provider: ^6.1.2`

### Implemented Features

1. **Freehand Drawing:**
   - Allows users to draw freehand shapes or lines directly on the map.
   - Implemented in `free_hand.dart`.

2. **Circle with Radius:**
   - Implemented in `circle.dart`.

3. **Marker Provider:**
   - Implemented in `marker_provider.dart`.

4. **Polyline Drawing:**
   - Implemented in `polyline_provider.dart`.

5. **Waypoint Drawing:**
   - Implemented in `waypoint.dart`.

## Getting Started

Follow these steps to get started with the app:

1. Clone the repository.
2. Ensure Flutter SDK is installed on your machine.
3. Run `flutter pub get` to install dependencies.
4. Set up MapBox custom map using MapBox Studio and obtain API credentials.
5. Replace placeholders in the code with your MapBox API keys.
6. Run the app using `flutter run`.

