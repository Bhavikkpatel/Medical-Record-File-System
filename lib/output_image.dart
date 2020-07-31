import 'package:flutter/material.dart';

class Outputimage extends StatefulWidget {
  @override
  _OutputimageState createState() => _OutputimageState(image);
  var image;

  Outputimage(this.image);
}

class _OutputimageState extends State<Outputimage> {
  var image;

  _OutputimageState(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: image,
      ),
    );
  }
}
