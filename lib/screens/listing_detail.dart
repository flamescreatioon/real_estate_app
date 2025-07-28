import 'package:flutter/material.dart';

class PropertyDetailsWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String details;
  final String description;
  final String ownerName;
  final String ownerRole;
  final double rating;
  final String propertyType;
  final int price;
  final String address;
  final double area;
  final int bedrooms;
  final int bathrooms;

  const PropertyDetailsWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.details,
    required this.propertyType,
    required this.price,
    required this.address,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(details, style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 16),
                Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(description),
                SizedBox(height: 16),
                Text('Owner/Agent Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/100')),
                  title: Text(ownerName),
                  subtitle: Text(ownerRole),
                  trailing: Icon(Icons.phone),
                ),
                SizedBox(height: 16),
                Text('Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('$rating ⭐ (200 Reviews)'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Book/View Property'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
