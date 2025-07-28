import "dart:io";
import "dart:convert";
import "package:path_provider/path_provider.dart";

class JsonDatabaseService{
  static JsonDatabaseService? _instance;
  static JsonDatabaseService get instance => _instance ??= JsonDatabaseService._();

  JsonDatabaseService._();

  static const String _propertiesFile = 'properties.json';
  static const String _favoritesFile = 'favorities.json';
  static const String _userDataFile = 'user_data.json';
  static const String _searchFiltersFile = 'search_filters.json';

  Future<Directory>get _documentsDirectory async{
    return await getApplicationDocumentsDirectory();
  }

  Future<Map<String, dynamic>> _readJsonFile(String fileName) async{
    try{
      final directory = await _documentsDirectory;
      final file = File('${directory.path}/$fileName');

      if(!await file.exists()){
        return{};
      }

      final contents = await file.readAsString();
      return json.decode(contents) as Map<String, dynamic>;
    }catch(e){
      print('Error Reading $fileName : $e');
      return{};
    }
  }

  Future<bool> _writeJsonFile(String filename, Map<String, dynamic> data) async{
    try{
      final directory = await _documentsDirectory;
      final file = File('$directory.path/$filename');

      await file.writeAsString(json.encode(data));
      return true;
    }catch(e){
      print('Error writing $filename: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getProperties() async{
    final data = await _readJsonFile(_propertiesFile);
    return List<Map<String, dynamic>>.from(data['properties']??[]);
  }

  Future<bool> saveProperties(List<Map<String, dynamic>> properties) async {
    return await _writeJsonFile(_propertiesFile, {'properties': properties});
  }

  Future<bool> addProperty(Map<String, dynamic> property) async {
    final properties = await getProperties();
    property['id'] = DateTime.now().millisecondsSinceEpoch.toString();
    properties.add(property);
    return await saveProperties(properties);
  }

  Future<bool> updateProperty(String id, Map<String, dynamic> updatedProperty) async {
    final properties = await getProperties();
    final index = properties.indexWhere((prop) => prop['id'] == id);

    if (index != -1) {
      properties[index] = {...updatedProperty, 'id': id};
      return await saveProperties(properties);
    }
    return false;
  }

  Future<bool> deleteProperty(String id) async {
    final properties = await getProperties();
    properties.removeWhere((prop) => prop['id'] == id);
    return await saveProperties(properties);
  }

  // Search properties by criteria
  Future<List<Map<String, dynamic>>> searchProperties({
    String? city,
    double? minPrice,
    double? maxPrice,
    String? propertyType,
  }) async {
    final properties = await getProperties();

    return properties.where((property) {
      if (city != null && property['city']?.toString().toLowerCase() != city.toLowerCase()) {
        return false;
      }
      if (minPrice != null && (property['price'] ?? 0) < minPrice) {
        return false;
      }
      if (maxPrice != null && (property['price'] ?? 0) > maxPrice) {
        return false;
      }
      if (propertyType != null && property['type'] != propertyType) {
        return false;
      }
      return true;
    }).toList();
  }

  // FAVORITES METHODS

  // Get user favorites
  Future<List<String>> getFavorites() async {
    final data = await _readJsonFile(_favoritesFile);
    return List<String>.from(data['favorites'] ?? []);
  }

  // Add to favorites
  Future<bool> addToFavorites(String propertyId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(propertyId)) {
      favorites.add(propertyId);
      return await _writeJsonFile(_favoritesFile, {'favorites': favorites});
    }
    return true;
  }

  // Remove from favorites
  Future<bool> removeFromFavorites(String propertyId) async {
    final favorites = await getFavorites();
    favorites.remove(propertyId);
    return await _writeJsonFile(_favoritesFile, {'favorites': favorites});
  }

  // Check if property is favorited
  Future<bool> isFavorite(String propertyId) async {
    final favorites = await getFavorites();
    return favorites.contains(propertyId);
  }

  // Get favorite properties
  Future<List<Map<String, dynamic>>> getFavoriteProperties() async {
    final favorites = await getFavorites();
    final allProperties = await getProperties();

    return allProperties.where((property) =>
        favorites.contains(property['id'])).toList();
  }

  // USER DATA METHODS

  // Save user data
  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await _writeJsonFile(_userDataFile, userData);
  }

  // Get user data
  Future<Map<String, dynamic>> getUserData() async {
    return await _readJsonFile(_userDataFile);
  }

  // SEARCH FILTERS METHODS

  // Save search filters
  Future<bool> saveSearchFilters(Map<String, dynamic> filters) async {
    return await _writeJsonFile(_searchFiltersFile, filters);
  }

  // Get search filters
  Future<Map<String, dynamic>> getSearchFilters() async {
    return await _readJsonFile(_searchFiltersFile);
  }

  // UTILITY METHODS

  // Clear all data
  Future<bool> clearAllData() async {
    final directory = await _documentsDirectory;
    try {
      await File('${directory.path}/$_propertiesFile').delete();
      await File('${directory.path}/$_favoritesFile').delete();
      await File('${directory.path}/$_userDataFile').delete();
      await File('${directory.path}/$_searchFiltersFile').delete();
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }

  // Initialize with sample data (for testing)
  Future<bool> initializeSampleData() async {
    final sampleProperties = [
      {
        'id': '1',
        'title': 'Modern 3BR Apartment',
        'description': 'Beautiful modern apartment with city views',
        'price': 350000.0,
        'city': 'New York',
        'type': 'apartment',
        'bedrooms': 3,
        'bathrooms': 2,
        'area': 1200.0,
        'images': ['image1.jpg', 'image2.jpg'],
        'agent': {
          'name': 'John Doe',
          'phone': '+1234567890',
          'email': 'john@realestate.com'
        },
        'location': {
          'latitude': 40.7128,
          'longitude': -74.0060
        },
        'featured': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': '2',
        'title': 'Cozy 2BR House',
        'description': 'Charming house in quiet neighborhood',
        'price': 280000.0,
        'city': 'Austin',
        'type': 'house',
        'bedrooms': 2,
        'bathrooms': 1,
        'area': 900.0,
        'images': ['image3.jpg', 'image4.jpg'],
        'agent': {
          'name': 'Jane Smith',
          'phone': '+1234567891',
          'email': 'jane@realestate.com'
        },
        'location': {
          'latitude': 30.2672,
          'longitude': -97.7431
        },
        'featured': false,
        'createdAt': DateTime.now().toIso8601String(),
      }
    ];

    return await saveProperties(sampleProperties);
  }
}