import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/property/listing_detail.dart';


class PropertyListItem extends StatelessWidget {
  final String propertyType;
  final double price;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int sqft;
  final String imageUrl;

  const PropertyListItem({
    super.key,
    required this.propertyType,
    required this.price,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.sqft,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailsScreen(
              propertyType: propertyType,
              price: price,
              address: address,
              bedrooms: bedrooms,
              bathrooms: bathrooms,
              sqft: sqft,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Property Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          // Property Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    buildFeatureIcon(Icons.bed, '$bedrooms Beds'),
                    const SizedBox(width: 8),
                    buildFeatureIcon(Icons.bathtub, '$bathrooms Baths'),
                    const SizedBox(width: 8),
                    buildFeatureIcon(Icons.square_foot, '$sqft sqft'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
  Widget buildFeatureIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.blue[700],
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}