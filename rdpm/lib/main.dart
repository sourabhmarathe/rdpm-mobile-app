import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'sakaPicker.dart';

import 'calendar.dart';
import 'sakaStruct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Welcome to the RPDM Mobile App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedGregorianDate = DateTime.now();
  SakaStruct convertedSakaDate;
  SakaStruct selectedSakaDate = convertToSakaDate(DateTime.now());
  DateTime convertedGregorianDate = DateTime.now();

  SakaPicker sakaPicker;

  /*
  * indianToGregorian: bool True = Indian to Greg conversion, false otherwise
   */
  void _translateDate(BuildContext context, bool indianToGregorian) {
    setState(() {
      if(indianToGregorian) {
        convertedSakaDate = convertToSakaDate(selectedGregorianDate);
      } else {
        convertedGregorianDate = convertToGregorianDate(selectedSakaDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Convert to Indian Civil Date"),
              Text("${selectedGregorianDate.toLocal()}".split(' ')[0]),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2015, 1, 1),
                        maxTime: DateTime(2025, 12, 31), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        selectedGregorianDate = date;
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'show date time picker',
                    style: TextStyle(color: Colors.blue),
                  )),
              RaisedButton(
                onPressed: () => _translateDate(context, true),
                child: Text('Translate date'),
              ),
              Text(convertedSakaDate.toString()),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Convert to Gregorian Date"),
              Text(selectedSakaDate.toString()),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                  onPressed: () {
                    DatePicker.showPicker(context,
                        showTitleActions: true,
                        pickerModel: sakaPicker, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        selectedSakaDate = convertToSakaDate(date);
                      });
                    });
                  },
                  child: Text(
                    'show date time picker',
                    style: TextStyle(color: Colors.blue),
                  )),
              RaisedButton(
                onPressed: () => _translateDate(context, false),
                child: Text('Translate date'),
              ),
              Text("${convertedGregorianDate.toLocal()}".split(' ')[0]),
            ],
          ),
        ]),
      ),
    );
  }
}
