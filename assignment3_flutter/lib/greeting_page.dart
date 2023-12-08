import 'package:flutter/material.dart';

class GreetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greeting Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add your three pictures here
          Image.asset('assets/picture1.jpg', width: 200, height: 200),
          Image.asset('assets/picture2.jpg', width: 200, height: 200),
          Image.asset('assets/picture3.jpg', width: 200, height: 200),
          SizedBox(height: 16), // Add some spacing between pictures and text
          Text(
            'Hello! Welcome to our Flutter App.',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
