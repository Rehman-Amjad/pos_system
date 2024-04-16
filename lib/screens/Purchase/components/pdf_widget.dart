import 'package:flutter/material.dart';

class PdfWidget extends StatelessWidget {
  String title;
  double size;
  PdfWidget({super.key, this.title = '', this.size = 16.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.black, fontSize: size),
    );
  }
}
