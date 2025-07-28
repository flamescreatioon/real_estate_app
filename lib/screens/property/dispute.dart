import 'package:flutter/material.dart';

class DisputePage extends StatefulWidget {
  const DisputePage({super.key});

  @override
  State<DisputePage> createState() => _DisputePageState();
}

class _DisputePageState extends State<DisputePage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello, this is the support team. We're reviewing your dispute and will get back to you within 24 hours.",
      isFromSupport: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      senderName: "Support",
    ),
    ChatMessage(
      text: "I have not received the security deposit back after 30 days of moving out. Please help.",
      isFromSupport: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      senderName: "Sophia",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Dispute',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Dispute Details Section
          Container(
            color: const Color(0xFFF8F9FA),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dispute ID: 1234567890',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                
                _buildInfoRow(
                  icon: Icons.home_outlined,
                  title: 'Property',
                  subtitle: '123 Main St, Anytown, USA',
                ),
                const SizedBox(height: 16),
                
                _buildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  title: 'Date',
                  subtitle: '2024-01-15',
                ),
                const SizedBox(height: 16),
                
                _buildInfoRow(
                  icon: Icons.access_time,
                  title: 'Status',
                  subtitle: 'Pending',
                ),
              ],
            ),
          ),
          
          // Messages Section
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessage(messages[index]);
                      },
                    ),
                  ),
                  
                  // Message Input
                  _buildMessageInput(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F4FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Column(
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
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4A90E2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isFromSupport 
            ? MainAxisAlignment.start 
            : MainAxisAlignment.end,
        children: [
          if (message.isFromSupport) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFDEB887),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/support_avatar.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 20,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: message.isFromSupport 
                  ? CrossAxisAlignment.start 
                  : CrossAxisAlignment.end,
              children: [
                if (message.isFromSupport)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.senderName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4A90E2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: message.isFromSupport 
                        ? const Color(0xFFF1F1F1) 
                        : const Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: message.isFromSupport ? Colors.black : Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
                
                if (!message.isFromSupport)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      message.senderName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          if (!message.isFromSupport) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFDEB887),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/user_avatar.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFDEB887),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/user_avatar.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isFromSupport: false,
            timestamp: DateTime.now(),
            senderName: "Sophia",
          ),
        );
      });
      
      _messageController.clear();
      
      // Scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isFromSupport;
  final DateTime timestamp;
  final String senderName;

  ChatMessage({
    required this.text,
    required this.isFromSupport,
    required this.timestamp,
    required this.senderName,
  });
}

// Usage example:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const DisputePage()),
// );