import 'package:flutter/material.dart';

/// Simple placeholder chat screen. Replace with real chat implementation later.
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(
        child: Text(
          'Chat feature coming soon',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
