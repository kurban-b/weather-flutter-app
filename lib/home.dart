import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/fetchTheData.dart';
import 'package:intl/intl.dart';
import 'navigationDraw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather> futureWeather;

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureWeather = fetchWeather();

    data = futureWeather;
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
                data = snapshot.data!.list[0];
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
                                            '${snapshot.data!.list[0]['main']['humidity']} %',
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
                          '${DateFormat('dd.MM.yyyy')
                              .format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.list[0]['dt'] * 1000))}',
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
                          '${DateFormat('hh:mm')
                              .format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.list[0]['dt'] * 1000))}',
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
              print(data);
              FirebaseFirestore.instance.collection('notes').add({'note': data});
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Запись добавлена'),
                  actions: [
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('OK'))
                  ],
                );
              });
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
                  Text('t°', style: TextStyle(fontSize: 30),),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                ],
              ),
            )
          ),
        )
    );
  }
}
