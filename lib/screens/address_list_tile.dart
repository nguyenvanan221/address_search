import 'package:flutter/material.dart';

class AddressListTile extends StatelessWidget {
  final String address;
  final VoidCallback press;
  final String searchQuery;
  const AddressListTile({
    super.key,
    required this.address,
    required this.press,
    required this.searchQuery,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          leading: Icon(Icons.location_on_outlined),
          title: _emphasizeMatchKeywords(address, searchQuery),
          trailing: Icon(Icons.directions_rounded),
        ),
      ],
    );
  }

  Widget _emphasizeMatchKeywords(String text, String searchQuery) {
    if (searchQuery.isEmpty) return Text(text);

    List<TextSpan> spans = [];
    int start = 0;

    while (start < text.length) {
      int index = text.toLowerCase().indexOf(searchQuery.toLowerCase(), start);

      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      } else {
        if (index > start) {
          spans.add(TextSpan(text: text.substring(start, index)));
        }
        spans.add(
          TextSpan(
            text: text.substring(index, index + searchQuery.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        );
        start = index + searchQuery.length;
      }
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
