import 'dart:convert';
import 'package:address_search/constants/constants.dart';
import 'package:address_search/model/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LocationController extends ChangeNotifier {
  List<Location> searchResults = [];
  String searchQuery = "";

  Future<void> searchLocations(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      notifyListeners();
      return;
    }

    searchQuery = query;

    final url =
        'https://us1.locationiq.com/v1/search?key=$apiKey&q=$query&limit=10&format=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        searchResults = data.map((json) => Location.fromJson(json)).toList();

        notifyListeners();
      } else {
        throw ("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw ('Error fetching location: $e');
    }
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> openGoogleMaps(Location location) async {
    Position currentLocation = await getCurrentLocation();

    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${location.lat},${location.lon}&travelmode=driving',
    );

    await launchUrl(url);
  }
}
