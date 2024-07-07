import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_service.dart';
import 'weather_details_screen.dart';
import 'weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.getString('lastSearchedCity');
    if (city != null) {
      _controller.text = city;
    }
  }

  void _searchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      Weather weather = await context.read<WeatherService>().fetchWeather(_controller.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastSearchedCity', _controller.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailsScreen(weather: weather),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not fetch weather data. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      backgroundColor: Colors.blueAccent.shade100,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            Center(child: Image.network('https://cdn-icons-png.flaticon.com/128/648/648198.png',scale: 0.5)),

            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : OutlinedButton(
              onPressed: _searchWeather,
              child: Text('Get Weather'),
              style: OutlinedButton.styleFrom(backgroundColor: Colors.white, textStyle: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 20),
              Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red))),
            ],
          ],
        ),
      ),
    );
  }
}
