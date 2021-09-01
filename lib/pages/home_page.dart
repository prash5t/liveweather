import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liveweather/api/Weather.dart';
//import 'package:http/http.dart' as http;
import 'package:liveweather/api/get_weather.dart';

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
  //var searchkey = formke
  //Future? currentWeather;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: searchClicked
              ? Form(
                  //key:  searchkey,
                  child: TextFormField(
                    onChanged: (value) {
                      city = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter a city name",
                        suffixIcon: IconButton(
                            onPressed: () {
                              searchClicked = false;

                              print(city);
                              setState(() {});
                            },
                            icon: Icon(Icons.close))),
                  ),
                )
              : Text("Live Weather"),
          actions: [
            IconButton(
                onPressed: () {
                  if (city != null) {
                    getweather = getWeather(place: "$city");
                    setState(() {});
                  }
                  searchClicked = true;

                  setState(() {});
                },
                icon: Icon(CupertinoIcons.search))
          ],
        ),
        //backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Weather?>(
                  future: getweather,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      //var weatherData = snapshot.data;

                      var imageByTemp =
                          defineBackground(snapshot.data?.current?.tempC);
                      return Container(
                        //color: Colors.white,
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "$imageByTemp",
                                ),
                                fit: BoxFit.cover)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SafeArea(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "TODAY",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  "${snapshot.data?.location?.name}, ${snapshot.data?.location?.country}",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18),
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
                                          image: NetworkImage(kIsWeb
                                              ? "${snapshot.data?.current?.condition?.icon}"
                                              : "http:${snapshot.data?.current?.condition?.icon}"),
                                          fit: BoxFit.cover)),
                                ),
                                Text(
                                  "${snapshot.data?.current?.tempC}° C",
                                  style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Text(
                                  "${snapshot.data?.current?.condition?.text}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                              "Incorrect City?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: size.height * 0.01),
                                Text("Loading... Please Wait"),
                              ],
                            )
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

  defineBackground(data) {
    var temperature = data;
    if (temperature < 15) {
      return "assets/cold_weather.png";
    } else if (temperature > 25) {
      return "assets/hot_weather.jpeg";
    } else {
      return "assets/mid_weather.jpeg";
    }
  }
}
