import 'package:flutter/material.dart';
import 'package:liveweather/pages/home_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: HomePage(),
  ));
}
