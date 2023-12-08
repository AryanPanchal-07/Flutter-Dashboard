import 'package:flutter/material.dart';
import 'news_component.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: NewsComponent(),
    );
  }
}
