import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liveweather/models/place_suggestion.dart';
import 'package:liveweather/trash.dart';

class WeatherAPI {
  String get apiKey => trash();

  Map<String, String> headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*"
  };

  Future<List<PlaceSuggestion?>?>? getSuggestions(String query) async {
    if (query.isEmpty) return null;
    var res = await http.get(
      Uri.parse(
        "http://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query",
      ),
    );

    return List<PlaceSuggestion>.from(
      (jsonDecode(res.body) as List).map((e) => PlaceSuggestion.fromMap(e)),
    );
  }
}

var weatherApi = WeatherAPI();
