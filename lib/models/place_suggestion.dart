class PlaceSuggestion {
  final int? id;
  final String? name;
  final String? country;
  final double? lat;
  final double? long;

  PlaceSuggestion({
    this.id,
    this.name,
    this.country,
    this.lat,
    this.long,
  });

  factory PlaceSuggestion.fromMap(Map<String, dynamic> map) {
    return PlaceSuggestion(
      id: map['id'],
      name: map['name'],
      country: map['country'],
      lat: map['lat'],
      long: map['long'],
    );
  }
}
