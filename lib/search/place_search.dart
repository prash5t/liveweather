import 'package:flutter/material.dart';
import 'package:liveweather/api/weather_api.dart';
import 'package:liveweather/models/place_suggestion.dart';

class PlaceSearch extends SearchDelegate {
  @override
  void showResults(BuildContext context) {}

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, PlaceSuggestion());
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<PlaceSuggestion?>?>(
      future: weatherApi.getSuggestions(query),
      builder: (context, snap) {
        if (snap.data == null) return Container();
        if (snap.connectionState == ConnectionState.done)
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (c, i) {
              var cur = snap.data![i];
              return ListTile(
                onTap: () {
                  close(context, cur);
                },
                title: Text(cur!.name.toString()),
                subtitle: Text(cur.country.toString()),
              );
            },
          );

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
