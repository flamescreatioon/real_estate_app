import 'package:flutter/material.dart';
import 'package:real_estate_app/services/jsonservice.dart';

class JsonItemsScreen extends StatefulWidget {
  const JsonItemsScreen({Key? key}) : super(key: key);

  @override
  State<JsonItemsScreen> createState() => _JsonItemsScreenState();
}

class _JsonItemsScreenState extends State<JsonItemsScreen> {
  final JsonService _service = JsonService();
  late Future<List<Map<String, dynamic>>> _future;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = _service.readJson();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    _nameCtrl.clear();
    _descCtrl.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final list = _service.items;
                list.add({
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'name': _nameCtrl.text.trim(),
                  'description': _descCtrl.text.trim(),
                });
                // Note: JsonService currently only reads bundled asset (read-only at runtime).
                // For persistence you'd extend JsonService to write to local jsondb service.
              });
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample JSON Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _future = _service.readJson();
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No items found'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['name'] ?? ''),
                subtitle: Text(item['description'] ?? ''),
                trailing: Text(item['id'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
