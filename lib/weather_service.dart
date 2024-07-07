import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class WeatherService {
  final String apiKey = 'd8d65c48ce2e6eec8a2584bc3b1e44bc';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
