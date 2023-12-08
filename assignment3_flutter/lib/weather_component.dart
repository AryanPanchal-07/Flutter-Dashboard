import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherComponent extends StatefulWidget {
  @override
  _WeatherComponentState createState() => _WeatherComponentState();
}

class _WeatherComponentState extends State<WeatherComponent> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace with your OpenWeatherMap API key
    const String apiKey = "1ff0f85841573f8543110133212ec280";
    const String apiUrl =
        "https://api.openweathermap.org/data/2.5/onecall?lat=44.38&lon=-79.69&exclude=minutely&appid=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          weatherData = data;
        });
      } else {
        throw Exception("Failed to fetch weather data");
      }
    } catch (error) {
      print("Error fetching weather data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: weatherData != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Weather"),
                    Text("Temperature: ${weatherData!['current']['temp']}°C"),
                    Text("Feels Like: ${weatherData!['current']['feels_like']}°C"),
                    Text("Pressure: ${weatherData!['current']['pressure']} hPa"),
                    Text("Humidity: ${weatherData!['current']['humidity']}%"),
                    Text("Dew Point: ${weatherData!['current']['dew_point']}°C"),
                    Text("UV Index: ${weatherData!['current']['uvi']}"),
                    Text("Clouds: ${weatherData!['current']['clouds']}%"),
                    Text("Visibility: ${weatherData!['current']['visibility']} meters"),
                    Text("Wind Speed: ${weatherData!['current']['wind_speed']} m/s"),
                    Text("Wind Degree: ${weatherData!['current']['wind_deg']}°"),
                    Text("Wind Gust: ${weatherData!['current']['wind_gust']} m/s"),
                    Text("Sunrise: ${DateTime.fromMillisecondsSinceEpoch(weatherData!['current']['sunrise'] * 1000).toLocal()}"),
                    Text("Sunset: ${DateTime.fromMillisecondsSinceEpoch(weatherData!['current']['sunset'] * 1000).toLocal()}"),
                    Text("Weather: ${weatherData!['current']['weather'][0]['description']}"),
                    Text("Hourly Forecast"),
                    Column(
                      children: [
                        for (var hour in weatherData!['hourly'])
                          ListTile(
                            title: Text("Time: ${DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000).toLocal()}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Temperature: ${hour['temp']}°C"),
                                Text("Feels Like: ${hour['feels_like']}°C"),
                                Text("Pressure: ${hour['pressure']} hPa"),
                                Text("Humidity: ${hour['humidity']}%"),
                                Text("Dew Point: ${hour['dew_point']}°C"),
                                Text("UV Index: ${hour['uvi']}"),
                                Text("Clouds: ${hour['clouds']}%"),
                                Text("Visibility: ${hour['visibility']} meters"),
                                Text("Wind Speed: ${hour['wind_speed']} m/s"),
                                Text("Wind Degree: ${hour['wind_deg']}°"),
                                Text("Wind Gust: ${hour['wind_gust']} m/s"),
                                Text("Weather: ${hour['weather'][0]['description']}"),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Text("Daily Forecast"),
                    Column(
                      children: [
                        for (var day in weatherData!['daily'])
                          ListTile(
                            title: Text("Date: ${DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).toLocal()}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Max Temperature: ${day['temp']['max']}°C"),
                                Text("Min Temperature: ${day['temp']['min']}°C"),
                                Text("Feels Like - Day: ${day['feels_like']['day']}°C"),
                                Text("Feels Like - Night: ${day['feels_like']['night']}°C"),
                                Text("Pressure: ${day['pressure']} hPa"),
                                Text("Humidity: ${day['humidity']}%"),
                                Text("Dew Point: ${day['dew_point']}°C"),
                                Text("UV Index: ${day['uvi']}"),
                                Text("Clouds: ${day['clouds']}%"),
                                Text("Wind Speed: ${day['wind_speed']} m/s"),
                                Text("Wind Degree: ${day['wind_deg']}°"),
                                Text("Wind Gust: ${day['wind_gust']} m/s"),
                                Text("Weather: ${day['weather'][0]['description']}"),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              : Text("Loading weather data..."),
        ),
      ),
    );
  }
}
