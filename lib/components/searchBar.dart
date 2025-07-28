import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/property/filters.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback onSearch;

  const SearchBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search properties, locations...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchFiltersScreen()));
        },
      ),
    );
  }
}
