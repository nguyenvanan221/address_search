import 'package:address_search/controller/location_controller.dart';
import 'package:address_search/screens/address_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationController(),
      child: MaterialApp(
        title: 'Address Search',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const AddressSearchScreen(),
      ),
    );
  }
}
