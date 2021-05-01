import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rdpm/SakaPickerModel.dart';

import 'calendar.dart';
import 'sakaStruct.dart';

class SakaToGregorianContainer extends StatefulWidget {
  SakaToGregorianContainer({Key key}) : super(key: key);

  @override
  _SakaToGregorianContainer createState() => _SakaToGregorianContainer();
}

class _SakaToGregorianContainer extends State<SakaToGregorianContainer> {
  SakaStruct selectedSakaDate = convertToSakaDate(DateTime.now());
  DateTime convertedGregorianDate = DateTime.now();

  SakaPickerModel _sakaPickerModel = new SakaPickerModel();

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
                    pickerModel: _sakaPickerModel, onConfirm: (date) {
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
            onPressed: () => setState(() {
              convertedGregorianDate = convertToGregorianDate(selectedSakaDate);
            }),
            child: Text('Translate date'),
          ),
          Text("${convertedGregorianDate.toLocal()}".split(' ')[0]),
        ],
      ),
    );
  }
}