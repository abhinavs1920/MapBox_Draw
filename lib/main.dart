import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/polyline_provider.dart';
import 'package:untitled/waypoint.dart';
import 'package:untitled/circle.dart';
import 'package:untitled/free_hand.dart';
import 'package:untitled/map_page.dart';

import 'marker_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarkerProvider()),
        ChangeNotifierProvider(create: (context) => PolylineProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Option'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Select Option'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text('Select Option'),
                  children: <Widget>[
                    SimpleDialogOption(
                      child: Text('Waypoint'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WaypointPage()),
                        );
                      },
                    ),
                    SimpleDialogOption(
                      child: Text('Freehand'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FreehandPage()),
                        );
                      },
                    ),
                    SimpleDialogOption(
                      child: Text('Polygon'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PolygonPage()),
                        );
                      },
                    ),
                    SimpleDialogOption(
                      child: Text('Circle'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CirclePage()),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
