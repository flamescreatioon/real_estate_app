import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today Section
            _buildSectionHeader('Today'),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'assets/house1.jpg', // Replace with your asset path
              'Booking confirmed',
              '10:30 AM',
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              'assets/house2.jpg', // Replace with your asset path
              'Payment received',
              '10:00 AM',
            ),
            
            const SizedBox(height: 32),
            
            // Yesterday Section
            _buildSectionHeader('Yesterday'),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'assets/house3.jpg', // Replace with your asset path
              'Booking confirmed',
              '10:30 AM',
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              'assets/house4.jpg', // Replace with your asset path
              'Payment received',
              '10:00 AM',
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildNotificationItem(String imagePath, String title, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // House Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback placeholder when image is not found
                  return Container(
                    color: Colors.blue[100],
                    child: Icon(
                      Icons.home,
                      color: Colors.blue[400],
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(Icons.search, true),
          _buildBottomNavItem(Icons.favorite_border, false),
          _buildBottomNavItem(Icons.add_circle_outline, false),
          _buildBottomNavItem(Icons.chat_bubble_outline, false),
          _buildBottomNavItem(Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.black : Colors.grey[400],
      ),
    );
  }
}