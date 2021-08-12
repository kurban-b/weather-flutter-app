import 'package:flutter/material.dart';
import 'package:flutter_weather_app/fetchTheData.dart';
import 'navigationDraw.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: StreamBuilder (
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Нет записей'),);
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    color: Colors.lightBlue,
                    child: Container(
                      padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('${snapshot.data!.docs[index]
                                      .get('note')['name']}',
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text('${(snapshot.data!.docs[index]
                                          .get('note')['main']['temp'] - 273.15)
                                          .round()} C°',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text('${DateFormat('dd.MM.yyyy')
                                          .format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index].get('note')['dt'] * 1000))}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Text('Влажность воздуха ${snapshot.data!.docs[index]
                                          .get('note')['main']['humidity']} %',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text('Скорость ветра ${snapshot.data!.docs[index]
                                          .get('note')['wind']['speed']} м/с',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                    ),
                  ),
                  onDismissed: (diraction) {
                    FirebaseFirestore.instance.collection('notes').doc(snapshot.data!.docs[index].id).delete();
                  },
                );
              }
          );
        },
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
    );
  }
}
