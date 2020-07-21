import 'package:flutter/material.dart';

class prescription_table {
  DataCell Medicine;
  DataCell Days;
  DataCell Morning;
  DataCell Afternoon;
  DataCell Evening;
  DataCell Night;

  prescription_table() {
    this.Medicine = genDataCell();
    this.Days = genDataCell();
    this.Morning = genDataCell();
    this.Afternoon = genDataCell();
    this.Evening = genDataCell();
    this.Night = genDataCell();
  }

  static DataCell genDataCell() {
    return DataCell(
      TextField(
        style: TextStyle(fontSize: 20.0),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          focusColor: Colors.black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                style: BorderStyle.none,
                color: Colors.black,
              )),
        ),
      ),
    );
  }

  int tablerows = 1;
}

final List<String> precriptionColumns = [
  'Medicine Name',
  '     Days     ',
  'Morning',
  'Afternoon',
  'Evening',
  'Night'
];
