import 'package:address_search/controller/location_controller.dart';
import 'package:address_search/debounce.dart';
import 'package:address_search/screens/address_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _debounce = Debounce(delay: Duration(milliseconds: 600));

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LocationController>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
              ),
              margin: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Enter keyword',
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        )
                      : null,
                ),
                onChanged: (query) {
                  _debounce.run(() => controller.searchLocations(query));
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final location = controller.searchResults[index];
                  return AddressListTile(
                    address: location.name,
                    press: () {
                      controller.openGoogleMaps(location);
                    },
                    searchQuery: controller.searchQuery,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
