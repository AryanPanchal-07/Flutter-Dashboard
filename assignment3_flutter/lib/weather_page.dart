import 'package:flutter/material.dart';
import 'weather_component.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
      ),
      body: WeatherComponent(),
    );
  }
}
