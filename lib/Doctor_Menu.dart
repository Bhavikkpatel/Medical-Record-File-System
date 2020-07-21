import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'prescription_table.dart';

class Doctor_Menu extends StatefulWidget {
  @override
  _Doctor_MenuState createState() => _Doctor_MenuState();
}

//class create_pdf{
//  Future<String> get _localPath async {
//    final directory = await getApplicationDocumentsDirectory();
//    return directory.path;
//  }
//  Future<File> get _localFile async {
//    final path = await _localPath;
//    return File('$path/counter.txt');
//  }
//  Future<File> writeCounter(int counter,PdfDocument document) async {
//    final file = await _localFile;
//    return File('SampleOutput.pdf').writeAsBytes(document.save());
//  }
//}

List<prescription_table> new_row = [
  prescription_table(),
];
PdfDocument document = PdfDocument();
PdfGrid grid = PdfGrid();

Padding genprescription() {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  grid.dataSource = DataTable(
                    dataRowHeight: 100.0,
                    columnSpacing: 23.0,
                    columns: precriptionColumns
                        .map(
                          (String column) => DataColumn(
                            label: Text(column),
                          ),
                        )
                        .toList(),
                    rows: new_row
                        .map((prescription_table table) => DataRow(
                              cells: [
                                table.Medicine,
                                table.Days,
                                table.Morning,
                                table.Afternoon,
                                table.Evening,
                                table.Night
                              ],
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

DataCell genDataCell() {
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

DataRow generaterow() {
  return DataRow(
    cells: <DataCell>[
      genDataCell(),
      genDataCell(),
      genDataCell(),
      genDataCell(),
      genDataCell(),
      genDataCell(),
    ],
  );
}

class _Doctor_MenuState extends State<Doctor_Menu> {
  AssetImage background = new AssetImage('assets/images/background3.jpg');
  bool Treat = false;
  bool _allowWriteFile = false;

//  @override
//  void initState() {
//    super.initState();
//    _requestWritePermission();
//  }
//
//  _requestWritePermission() async {
//    PermissionStatus permissionStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//
//    if (permissionStatus == PermissionStatus.authorized) {
//      setState(() {
//        _allowWriteFile = true;
//      });
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: background, fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Treat ? genprescription() : Container(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: Treat
                              ? RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      new_row.add(prescription_table());
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                        // width: 10.0,
                                      )),
                                  child: Text(
                                    'Add Row',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "CenturyGothic",
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  elevation: 5,
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: Treat
                              ? RaisedButton(
                                  onPressed: () {
                                    grid.draw(
                                        page: document.pages.add(),
                                        bounds:
                                            const Rect.fromLTWH(0, 0, 0, 0));
//                                    create_pdf().writeCounter(1, document);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                        // width: 10.0,
                                      )),
                                  child: Text(
                                    'Save',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "CenturyGothic",
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  elevation: 5,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ],
//                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                if (Treat == false) {
                                  Treat = true;
                                } else {
                                  Treat = false;
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.black,
                                  // width: 10.0,
                                )),
                            child: Text(
                              'Treat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "CenturyGothic",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            textColor: Colors.white,
                            elevation: 5,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 120.0,
                          child: RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.black,
                                  // width: 10.0,
                                )),
                            child: Text(
                              'History',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "CenturyGothic",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            textColor: Colors.white,
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
