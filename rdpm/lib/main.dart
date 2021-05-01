import 'package:flutter/material.dart';

import 'package:rdpm/gregorianToSaka.dart';
import 'package:rdpm/sakaToGregorian.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RDPM Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text("Saka to Gregorian"),
                Text("Gregorian to Saka"),
              ],
            ),
            title: Text("Saka <--> Gregorian Date Converter"),
          ),
          body: TabBarView(
            children: [
              SakaToGregorianContainer(),
              GregorianToSakaContainer(),
            ],
          ),
        )
      )
    );
  }
}