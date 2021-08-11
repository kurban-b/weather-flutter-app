import 'package:flutter/material.dart';
import 'package:flutter_weather_app/fetchTheData.dart';

class NavigationDraw extends StatefulWidget {
  const NavigationDraw({Key? key}) : super(key: key);

  @override
  _NavigationDraw createState() => _NavigationDraw();
}

class _NavigationDraw extends State<NavigationDraw> {

  late Future<Weather> futureWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                child: FutureBuilder<Weather>(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${(snapshot.data!.list[0]['main']['temp'] - 273.15).round()} C°',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${snapshot.data!.list[0]['name']}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      }
                      return Text('t°', style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),);
                    })),
            ListTile(
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
              title: Text('Главная'),
            ),
            ListTile(
              leading: Icon(Icons.notes),
              onTap: () {
                Navigator.pushNamed(context, '/notes');
              },
              title: Text('Контрольные заметки'),
            ),
          ],
        ),
      ),
    );
  }
}
