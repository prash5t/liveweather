class Weather {
  final String city;
  final String country;
  final double celcius;
  final double fahrenheit;
  final String condition;
  final String image;
  final bool isDay;

  Weather(this.city, this.country, this.celcius, this.fahrenheit,
      this.condition, this.image, this.isDay);

  factory Weather.fromResponse(Map<String, dynamic> map) {
    return Weather(
      map['location']['name'],
      map['location']['country'],
      map['current']['temp_c'],
      map['current']['temp_f'],
      map['current']['condition']['text'],
      map['current']['condition']['icon'],
      map['current']['is_day'] == 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        other.city == city &&
        other.country == country &&
        other.celcius == celcius &&
        other.fahrenheit == fahrenheit &&
        other.condition == condition &&
        other.image == image &&
        other.isDay == isDay;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        country.hashCode ^
        celcius.hashCode ^
        fahrenheit.hashCode ^
        condition.hashCode ^
        image.hashCode ^
        isDay.hashCode;
  }

  @override
  String toString() {
    return 'Weather(city: $city, country: $country, celcius: $celcius, fahrenheit: $fahrenheit, condition: $condition, image: $image, isDay: $isDay)';
  }
}
