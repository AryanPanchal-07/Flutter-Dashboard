import 'package:flutter/material.dart';
import 'calculator.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Page'),
      ),
      body: Calculator(),
    );
  }
}
