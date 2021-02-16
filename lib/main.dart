import 'package:flutter/material.dart';

import 'screens/location_screen.dart';

void main() => runApp(ClimaApp());

class ClimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima',
      theme: ThemeData.dark(),
      home: LocationScreen(),
    );
  }
}
