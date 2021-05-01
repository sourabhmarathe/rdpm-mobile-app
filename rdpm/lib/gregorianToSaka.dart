import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'calendar.dart';
import 'sakaStruct.dart';

class GregorianToSakaContainer extends StatefulWidget {
  GregorianToSakaContainer({Key key}) : super(key: key);

  @override
  _GregorianToSakaContainer createState() => _GregorianToSakaContainer();
}

class _GregorianToSakaContainer extends State<GregorianToSakaContainer> {
  DateTime selectedGregorianDate = DateTime.now();
  SakaStruct convertedSakaDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    maxTime: DateTime(2025, 12, 31),
                    onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        selectedGregorianDate = date;
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en);
              },
              child: Text(
                'show date time picker',
                style: TextStyle(color: Colors.blue),
              )),
          RaisedButton(
            onPressed: () => setState(() {
              convertedSakaDate = convertToSakaDate(selectedGregorianDate);
            }),
            child: Text('Translate date'),
          ),
          Text(convertedSakaDate.toString()),
        ],
      ),
    );
  }
}