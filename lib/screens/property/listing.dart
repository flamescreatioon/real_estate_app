import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/property/add_property.dart';
import 'package:real_estate_app/components/propertylistcard.dart';

class MyListingPage extends StatelessWidget{

  @override
 Widget build(BuildContext context){
  final propertyListings =[
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': '2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
      'bedrooms': '3',
      'bathrooms': '2',
      'sqft': '1200',
    },
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': '2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
      'bedrooms': '3',
      'bathrooms': '2',
      'sqft': '1200',
    },
     {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': '2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
      'bedrooms': '3',
      'bathrooms': '4',
      'sqft': '1800',
    },
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': '2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
      'bedrooms': '3',
      'bathrooms': '3',
      'sqft': '1500',
    },
  ];

  return(
    Scaffold(
      appBar: AppBar(
        title: const Text('My listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: (){

            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: (){

            },
          ),
        ],
      ),
      body: propertyListings.isEmpty ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_work_outlined,  size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Your property listings will appear here',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      )
      : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: propertyListings.length,
        itemBuilder: (context, index){
          final listing = propertyListings[index];
          return PropertyListingCard(
            listing: listing,
            onEdit: (){

            },
            onDelete: (){

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return const AddEditPropertyPage(propertyData: {},);
              })
            );
        },
        child: const Icon(Icons.add),
      ),
    )
  );
 }
}

