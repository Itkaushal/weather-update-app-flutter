import 'package:flutter/material.dart';
import 'weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  WeatherDetailsScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('City: ${weather.cityName}', style: TextStyle(fontSize: 20)),
            Text('Temperature: ${weather.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 20)),
            Text('Condition: ${weather.condition}', style: TextStyle(fontSize: 20)),
            Image.network('http://openweathermap.org/img/wn/${weather.icon}.png'),
            Text('Humidity: ${weather.humidity}%', style: TextStyle(fontSize: 20)),
            Text('Wind Speed: ${weather.windSpeed} m/s', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
