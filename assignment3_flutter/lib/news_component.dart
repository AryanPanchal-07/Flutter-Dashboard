import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsComponent extends StatefulWidget {
  @override
  _NewsComponentState createState() => _NewsComponentState();
}

class _NewsComponentState extends State<NewsComponent> {
  List<dynamic>? newsData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace with your NewsAPI key
    const String apiKey = "f032f23836cc43ffb2e9cfba49bd12c7";
    const String apiUrl =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          newsData = data['articles'];
        });
      } else {
        throw Exception("Failed to fetch news data");
      }
    } catch (error) {
      print("Error fetching news data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: newsData != null
                ? Column(
                    children: [
                      Text("News about Tesla", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      for (var article in newsData!)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title: ${article['title']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("Published at: ${article['publishedAt']}"),
                              Text("Description: ${article['description']}"),
                            ],
                          ),
                        ),
                    ],
                  )
                : Text("Loading news data..."),
          ),
        ),
      ),
    );
  }
}
