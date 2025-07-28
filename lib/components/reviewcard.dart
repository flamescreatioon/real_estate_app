import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String timeAgo;
  final int rating;
  final String review;
  final int likes;
  final int dislikes;
  final String avatarUrl;

  const ReviewCard({
    Key? key,
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.review,
    required this.likes,
    required this.dislikes,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Star Rating
          Row(
            children: [
              ...List.generate(
                  rating,
                  (index) => Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: 16,
                      )),
              ...List.generate(
                  5 - rating,
                  (index) => Icon(
                        Icons.star_border,
                        color: Colors.blue,
                        size: 16,
                      )),
            ],
          ),

          SizedBox(height: 12),

          Text(
            review,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),

          SizedBox(height: 16),

          // Like/Dislike Buttons
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$likes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    Icons.thumb_down_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$dislikes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
