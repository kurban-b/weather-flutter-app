import 'package:flutter/material.dart';
import 'package:flutter_weather_app/fetchTheData.dart';
import 'navigationDraw.dart';

class Measurements extends StatefulWidget {
  const Measurements({Key? key}) : super(key: key);

  @override
  _MeasurementsState createState() => _MeasurementsState();
}

class _MeasurementsState extends State<Measurements> {

  late Future<Weather> futureWeather;

  List items = [];

  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  items.addAll(['one', 'two', 'three']);
  futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода'),
      ),
      drawer: NavigationDraw(),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(items[index]),
                child: Card(
                  child: Container(
                    child: ListTile(
                      title: Text('${items[index]}'),
                      subtitle: Text('${items[index]}'),
                    )
                  ),
                ),
                onDismissed: (diraction) {
                  items.removeAt(index);
                },
            );
          }
      )
    );
  }
}
