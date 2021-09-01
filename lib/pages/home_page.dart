import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:liveweather/api/get_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Future? currentWeather;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        //backgroundColor: Colors.transparent,
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
                      weatherData["location"]["name"].toString().toUpperCase();
                  String? currentCountry = weatherData["location"]["country"]
                      .toString()
                      .toUpperCase();
                  String? currentCelcius =
                      weatherData["current"]["temp_c"].toString();
                  String? currentStatus =
                      weatherData["current"]["condition"]["text"].toString();
                  String? statusIcon =
                      weatherData["current"]["condition"]["icon"].toString();
                  print(statusIcon);
                  print("success");
                  return Container(
                    //color: Colors.white,
                    height: size.height,
                    width: size.width,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage(
                    //           "assets/bg.png",
                    //         ),
                    //         fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SafeArea(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "TODAY",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              "$currentAddress, $currentCountry",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 18),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            Container(
                              //color: Colors.blue,
                              height: size.height * 0.3,
                              width: size.height * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage("http:$statusIcon"),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              "$currentCelcius° C",
                              style: TextStyle(
                                  fontSize: 80, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Text(
                              "$currentStatus",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
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
                          style: TextStyle(color: Colors.white, fontSize: 25),
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
