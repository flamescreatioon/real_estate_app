import 'package:flutter/material.dart';

class AddEditPropertyPage extends StatelessWidget {
  final bool isEditing; // Ensure this is explicitly typed as bool
  final Map<String, dynamic> propertyData;

  const AddEditPropertyPage({
    Key? key,
    this.isEditing = false,
    required this.propertyData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample property features for checkboxes
    final features = [
      'Air Conditioning',
      'Balcony',
      'Elevator',
      'Garage',
      'Garden',
      'Gym',
      'Pool',
      'Security System',
      'Wi-Fi',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Property' : 'Add New Property'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.preview),
              tooltip: 'Preview Listing',
              onPressed: () {
                // Preview functionality would go here
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Gallery Section
              const Text(
                'Property Photos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Add photo button
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo, size: 32),
                          SizedBox(height: 8),
                          Text('Add Photo'),
                        ],
                      ),
                    ),
                    // Sample existing photos (in edit mode)
                    if (isEditing)
                      for (int i = 0; i < 3; i++)
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.home,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.close, size: 16),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      // Remove photo functionality would go here
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Basic Information
              const Text(
                'Basic Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: isEditing ? propertyData['title'] ?? '' : '',
                decoration: const InputDecoration(
                  labelText: 'Property Title*',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Modern Apartment in Downtown',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Property Type*',
                        border: OutlineInputBorder(),
                      ),
                      value: isEditing ? propertyData['type'] : null,
                      hint: const Text('Select type'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Apartment',
                          child: Text('Apartment'),
                        ),
                        DropdownMenuItem(
                          value: 'House',
                          child: Text('House'),
                        ),
                        DropdownMenuItem(
                          value: 'Condo',
                          child: Text('Condo'),
                        ),
                        DropdownMenuItem(
                          value: 'Commercial',
                          child: Text('Commercial'),
                        ),
                        DropdownMenuItem(
                          value: 'Land',
                          child: Text('Land'),
                        ),
                      ],
                      onChanged: (value) {
                        // Property type selection functionality would go here
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Listing Type*',
                        border: OutlineInputBorder(),
                      ),
                      value: isEditing ? propertyData['listingType'] : null,
                      hint: const Text('Select type'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Sale',
                          child: Text('For Sale'),
                        ),
                        DropdownMenuItem(
                          value: 'Rent',
                          child: Text('For Rent'),
                        ),
                      ],
                      onChanged: (value) {
                        // Listing type selection functionality would go here
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? propertyData['price'].toString() : '',
                decoration: const InputDecoration(
                  labelText: 'Price*',
                  border: OutlineInputBorder(),
                  prefixText: '\$ ',
                  hintText: 'e.g., 250000',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Location
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: isEditing ? propertyData['address'] : '',
                decoration: const InputDecoration(
                  labelText: 'Street Address*',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., 123 Main St',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['city'] : '',
                      decoration: const InputDecoration(
                        labelText: 'City*',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['state'] : '',
                      decoration: const InputDecoration(
                        labelText: 'State*',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['zipCode'] : '',
                      decoration: const InputDecoration(
                        labelText: 'Zip Code*',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['country'] : 'USA',
                      decoration: const InputDecoration(
                        labelText: 'Country*',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Property Details
              const Text(
                'Property Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['bedrooms'].toString() : '',
                      decoration: const InputDecoration(
                        labelText: 'Bedrooms',
                        border: OutlineInputBorder(),
                        suffixText: 'beds',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['bathrooms'].toString() : '',
                      decoration: const InputDecoration(
                        labelText: 'Bathrooms',
                        border: OutlineInputBorder(),
                        suffixText: 'baths',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['area'].toString() : '',
                      decoration: const InputDecoration(
                        labelText: 'Area',
                        border: OutlineInputBorder(),
                        suffixText: 'sq ft',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: isEditing ? propertyData['yearBuilt'].toString() : '',
                      decoration: const InputDecoration(
                        labelText: 'Year Built',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Features
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: features.map((feature) {
                  bool isSelected = isEditing && 
                      propertyData['features'] != null && 
                      (propertyData['features'] as List).contains(feature);
                  
                  return FilterChip(
                    label: Text(feature),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      // Feature selection functionality would go here
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? propertyData['customFeature'] : '',
                decoration: const InputDecoration(
                  labelText: 'Add Custom Feature',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., EV Charging Station',
                  suffixIcon: Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 24),

              // Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: isEditing ? propertyData['description'] : '',
                decoration: const InputDecoration(
                  hintText: 'Describe your property...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 24),

              // Availability
              const Text(
                'Availability',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InputDatePickerFormField(
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                      initialDate: isEditing && propertyData['availableFrom'] != null
                          ? DateTime.parse(propertyData['availableFrom'])
                          : DateTime.now(),
                      fieldLabelText: 'Available From',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Contact Information
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: isEditing ? propertyData['contactName'] : '',
                decoration: const InputDecoration(
                  labelText: 'Contact Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? propertyData['contactPhone'] : '',
                decoration: const InputDecoration(
                  labelText: 'Contact Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? propertyData['contactEmail'] : '',
                decoration: const InputDecoration(
                  labelText: 'Contact Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Visibility Settings
              const Text(
                'Visibility Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SwitchListTile(
                title: const Text('Public Listing'),
                subtitle: const Text('Make this property visible to everyone'),
                value: isEditing ? propertyData['isPublic'] : true,
                onChanged: (bool value) {
                  // Visibility toggle functionality would go here
                },
              ),
              SwitchListTile(
                title: const Text('Featured Listing'),
                subtitle: const Text('Highlight this property in search results'),
                value: isEditing ? propertyData['isFeatured'] : false,
                onChanged: (bool value) {
                  // Featured toggle functionality would go here
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Save/Update functionality would go here
                  },
                  child: Text(
                    isEditing ? 'Update Property' : 'Add Property',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Cancel Button (only in edit mode)
              if (isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}