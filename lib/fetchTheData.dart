import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<Weather> fetchWeather() async {
  final geo = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/find?lat=${geo.latitude}&lon=${geo.longitude}&cnt=1&appid=f8c9d469332454cad8b9864264de12c8&lang=ru'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class Weather {
  final String message;
  final int code;
  final int count;
  final List<dynamic> list;

  Weather({
    required this.message,
    required this.code,
    required this.count,
    required this.list,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      message: json['message'],
      code: json['code'],
      count: json['count'],
      list: json['list'],
    );
  }
}

