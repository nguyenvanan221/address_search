class Location {
  final String name;
  final String lat;
  final String lon;

  Location({required this.name, required this.lat, required this.lon});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['display_name'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
