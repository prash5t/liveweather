import 'package:flutter/material.dart';
import 'package:liveweather/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: HomePage(),
  ));
}
