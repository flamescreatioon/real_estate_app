import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/property/listing_detail.dart';

class PropertyListingCard extends StatelessWidget {
  final Map<String, String> listing;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PropertyListingCard({
    Key? key,
    required this.listing,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PropertyDetailsScreen(
                        propertyType: listing['title'] ?? '',
                        price: double.tryParse(listing['price'] ?? '') ?? 0.0,
                        address: listing['address'] ?? '',
                        bedrooms: double.tryParse(listing['bedrooms'] ?? '0')
                                ?.toInt() ??
                            0,
                        bathrooms: double.tryParse(listing['bathrooms'] ?? '0')
                                ?.toInt() ??
                            0,
                        sqft:
                            double.tryParse(listing['sqft'] ?? '0')?.toInt() ??
                                0,
                        imageUrl: listing['image'] ??
                            'https://placeholder.com/350x400',
                      )));
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.home,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        listing['status'] ?? ' ',
                        style: TextStyle(
                          color: listing['status'] == 'Active'
                              ? Colors.white
                              : Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: listing['status'] == 'Active'
                          ? Colors.green
                          : listing['status'] == 'Pending'
                              ? Colors.amber
                              : Colors.grey,
                      padding: const EdgeInsets.all(0),
                    ),
                    Text(
                      listing['type'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      listing['address'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      listing['price'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                      onPressed: onEdit,
                    ),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      label: const Text('Remove',
                          style: TextStyle(color: Colors.red)),
                      onPressed: onEdit,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
