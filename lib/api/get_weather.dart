import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../trash.dart';

Future getWeather() async {
  final String key = trash();
  final String query = "auto:ip";
  final String usedAPI =
      "http://api.weatherapi.com/v1/current.json?key=$key&q=$query";

  try {
    final response = await http.get(Uri.parse(usedAPI));
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      return decodedResponse;
    } else {
      return "Bad Request";
    }
  } catch (e) {
    return null;
  }
}
