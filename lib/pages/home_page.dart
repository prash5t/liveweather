import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liveweather/api/get_weather.dart';
import 'package:liveweather/constants/assets.dart';
import 'package:liveweather/constants/styles.dart';
import 'package:liveweather/models/place_suggestion.dart';
import 'package:liveweather/models/weather.dart';
import 'package:liveweather/search/place_search.dart';
import 'package:liveweather/extensions/date_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchClicked = false;
  String? city;
  TextEditingController searchbar = TextEditingController();
  var getweather;
  @override
  void initState() {
    getweather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          PlaceSuggestion res = await showSearch(
            context: context,
            delegate: PlaceSearch(),
          );
          if (res.name == null) return;
          getweather = getWeather(place: "${res.name}");

          searchClicked = true;

          setState(() {});
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.white,
        child: Center(
          child: Icon(
            Icons.search,
            size: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Weather?>(
          future: getweather,
          builder: (context, snapshot) {
            // return _buildFailed();
            if (snapshot.hasData) {
              var weather = snapshot.data;
              if (weather == null) return _buildFailed();
              return _buildSuccess(weather);
            }
            if (snapshot.hasError) return _buildFailed();
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  defineBackground(data) {
    var temperature = data;
    if (temperature < 18) {
      return "assets/cold_weather.png";
    } else if (temperature > 25) {
      return "assets/hot_weather.jpeg";
    } else {
      return "assets/mid_weather.jpeg";
    }
  }

  Widget _buildFailed() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Incorrect City?",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () {
              getweather = getWeather();
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 5),
                Icon(Icons.close, color: Colors.white),
                Text("Close", style: TextStyle(color: Colors.white)),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(Weather weather) {
    var now = DateTime.now();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.mid_weather),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    weather.city,
                    style: shadowedStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    now.stringify(),
                    style: shadowedStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${weather.celcius} °C",
                    style: shadowedStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 80,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      11,
                      (i) => Container(
                        height: 3,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 0.1,
                              spreadRadius: 0.1,
                            )
                          ],
                        ),
                        margin:
                            (i == 10) ? null : const EdgeInsets.only(right: 5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Colors.blue,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          kIsWeb ? weather.image : "https:${weather.image}",
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          weather.condition,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
