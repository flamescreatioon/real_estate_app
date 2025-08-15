import 'package:flutter/material.dart';

/// Basic profile screen placeholder. Extend with real user data later.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 48)),
          SizedBox(height: 16),
          Text('User Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('email@example.com'),
          SizedBox(height: 24),
          ListTile(
              leading: Icon(Icons.settings), title: Text('Account Settings')),
          ListTile(
              leading: Icon(Icons.history), title: Text('Activity History')),
          ListTile(leading: Icon(Icons.logout), title: Text('Sign Out')),
        ],
      ),
    );
  }
}
