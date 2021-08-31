import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:liveweather/api/get_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? currentWeather;
//to get current weather as soon as app opens

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getWeather(),
                  builder: (context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      var weatherData = snapshot.data;
                      String? currentAddress =
                          weatherData["location"]["name"].toString();
                      String? currentCountry =
                          weatherData["location"]["country"].toString();
                      String? currentCelcius =
                          weatherData["current"]["temp_c"].toString();
                      String? currentFr =
                          weatherData["current"]["temp_f"].toString();
                      String? currentStatus = weatherData["current"]
                              ["condition"]["text"]
                          .toString();
                      print("success");
                      return Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/cold_weather.png",
                                ),
                                fit: BoxFit.cover)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text(
                                        "$currentCelcius Celcius, $currentFr F"),
                                    Text(
                                        "Address: $currentAddress/$currentCountry"),
                                    Text("Weather Status: $currentStatus")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      print("failure");
                      return Center(
                          child: Container(
                        width: size.width,
                        height: size.height,
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "No Internet, Refresh",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            IconButton(
                                onPressed: () {
                                  print("pressed");
                                  getWeather();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 50,
                                ))
                          ],
                        ),
                      ));
                    }

                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ));
  }
}
