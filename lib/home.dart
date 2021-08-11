import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/fetchTheData.dart';
import 'navigationDraw.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            title: Text('Погода'),
          ),
          drawer: NavigationDraw(),
          body: FutureBuilder<Weather>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 20, top: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlue),
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          '${snapshot.data!.list[0]['name']}',
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                        child: Text(
                                          '${snapshot.data!.list[0]['weather'][0]['description']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${(snapshot.data!.list[0]['main']['temp'] - 273.15).round()} C°',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(right: 20)),
                                      Column(
                                        children: [
                                          Container(
                                            child: Image(
                                                image: NetworkImage(
                                                    'http://openweathermap.org/img/wn/${snapshot.data!.list[0]['weather'][0]['icon']}@2x.png')),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${snapshot.data!.list[0]['wind']['speed']} м/с',
                                            style: TextStyle(fontSize: 30,color: Colors.white,),
                                          ),
                                          Text('Скорость ветра', style: TextStyle(fontSize: 15,color: Colors.white,),)
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(right: 10)),
                                      Column(
                                        children: [
                                          Text(
                                            '${snapshot.data!.list[0]['main']['humidity']} °',
                                            style: TextStyle(fontSize: 30,color: Colors.white,),
                                          ),
                                          Text('Влажность воздуха', style: TextStyle(fontSize: 15,color: Colors.white,),)
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '01.10.2021',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '9:30',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return Center(
                child: const CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {

            },
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrange,
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.lightBlue,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('t°'),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                ],
              ),
            )
          ),
        )
    );
  }
}
