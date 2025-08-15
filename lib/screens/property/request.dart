import 'package:flutter/material.dart';

class PropertyRequestsScreen extends StatefulWidget {
  const PropertyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<PropertyRequestsScreen> createState() => _PropertyRequestsScreenState();
}

class _PropertyRequestsScreenState extends State<PropertyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'Transactions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[500],
                indicatorColor: Colors.blue,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(text: 'Current'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Past'),
                ],
              ),
              Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentTab(),
          _buildPendingTab(),
          _buildPastTab(),
        ],
      ),
    );
  }

  Widget _buildCurrentTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTransactionItem(
            'assets/apartment.jpg',
            'Rent Payment',
            '123 Main St, Apt 4B',
            '\$1,200',
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            'assets/house.jpg',
            'Security Deposit',
            '456 Oak Ave, House',
            '\$2,400',
          ),
          const SizedBox(height: 16),
          _buildTransactionItem(
            'assets/condo.jpg',
            'Lease Renewal Fee',
            '789 Pine Ln, Condo',
            '\$500',
          ),
        ],
      ),
    );
  }

  Widget _buildPendingTab() {
    return const Center(
      child: Text(
        'No pending transactions',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPastTab() {
    return const Center(
      child: Text(
        'No past transactions',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String imagePath,
    String title,
    String address,
    String amount,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Property Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback placeholder when image is not found
                  return Container(
                    color: _getPlaceholderColor(title),
                    child: Icon(
                      Icons.apartment,
                      color: Colors.white,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Transaction Details
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
                  address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPlaceholderColor(String title) {
    switch (title) {
      case 'Rent Payment':
        return Colors.blue[400]!;
      case 'Security Deposit':
        return Colors.orange[400]!;
      case 'Lease Renewal Fee':
        return Colors.green[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}
