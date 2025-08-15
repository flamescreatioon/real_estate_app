import 'dart:convert';
import 'package:flutter/services.dart';

class JsonService {
  List _items = [];

  List<Map<String, dynamic>> get items => List<Map<String, dynamic>>.from(
      _items.map((e) => Map<String, dynamic>.from(e as Map)));

  Future<List<Map<String, dynamic>>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/sample.json');
    final data = json.decode(response);
    _items = data["items"] ?? [];
    return items;
  }
}
