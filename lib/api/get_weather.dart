import 'dart:convert';
import 'dart:io';

//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:liveweather/models/weather.dart';
import '../trash.dart';

Future<Weather?> getWeather({String place = "auto:ip"}) async {
  final String key = trash();
  //final String query = "auto:ip";
  final String usedAPI = kIsWeb
      ? "//api.weatherapi.com/v1/current.json?key=$key&q=$place"
      : "http://api.weatherapi.com/v1/current.json?key=$key&q=$place";
  try {
    final response = await http.get(Uri.parse(usedAPI), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      var decodedResponse = Weather.fromResponse(jsonDecode(response.body));
      return decodedResponse;
    }
    return null;
  } catch (e) {}
}
