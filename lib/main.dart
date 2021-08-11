import 'package:flutter/material.dart';
import 'package:flutter_weather_app/home.dart';
import 'package:flutter_weather_app/measurements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.lightBlue),
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/notes': (context) => Measurements(),
    },
  ));
}


