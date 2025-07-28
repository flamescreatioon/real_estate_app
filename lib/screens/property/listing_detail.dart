import 'package:flutter/material.dart';
import 'package:real_estate_app/components/ratingbar.dart';
import 'package:real_estate_app/components/reviewcard.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final int propertyId;
  final String propertyType;
  final double price;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int sqft;
  final String imageUrl;

  const PropertyDetailsScreen({
    super.key,
    this.propertyId = 1,
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Property Image with App Bar
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Title and Description
                    Text(
                      propertyType,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'NGN${price.toString()}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      ' $propertyType is nested in a quiet neighborhood, this 3-bedroom home offers a perfect blend of comfort and style. Features include a spacious living area, modern kitchen, and a private backyard.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Property Details

                      children: [
                        // Bedrooms
                        Row(
                          children: [
                            Icon(Icons.bed, color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '$bedrooms Bedrooms',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // Bathrooms
                        Row(
                          children: [
                            Icon(Icons.bathtub, color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '$bathrooms Bathrooms',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // Square Footage
                        Row(
                          children: [
                            Icon(Icons.square_foot,
                                color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '$sqft sqft',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    // Host Section
                    Text(
                      'About the Host',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ethan Harper',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Host',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    // Reviews Section
                    Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Rating Summary
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overall Rating
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4.8',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                    4,
                                    (index) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 20,
                                        )),
                                Icon(
                                  Icons.star_border,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '120 reviews',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 40),

                        // Rating Bars
                        Expanded(
                          child: Column(
                            children: [
                              RatingBar(rating: 5, percentage: 70),
                              RatingBar(rating: 4, percentage: 20),
                              RatingBar(rating: 3, percentage: 5),
                              RatingBar(rating: 2, percentage: 3),
                              RatingBar(rating: 1, percentage: 2),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    // Individual Reviews
                    ReviewCard(
                      name: 'Sophia Bennett',
                      timeAgo: '2 weeks ago',
                      rating: 5,
                      review:
                          'Absolutely loved my stay! The house was clean, well-maintained, and had everything we needed. The host was very responsive and helpful.',
                      likes: 15,
                      dislikes: 2,
                      avatarUrl:
                          'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                    ),

                    SizedBox(height: 20),

                    ReviewCard(
                      name: 'Liam Carter',
                      timeAgo: '1 month ago',
                      rating: 4,
                      review:
                          'Great place to stay. The house was as described, and the location was perfect for our needs. Would definitely recommend.',
                      likes: 8,
                      dislikes: 1,
                      avatarUrl:
                          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                    ),

                    const SizedBox(height: 100), // Bottom padding for buttons
                  ],
                ),
              ),
            ),
          ],
        ),

        // Bottom Action Bar
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Book action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Book',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // View action
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
