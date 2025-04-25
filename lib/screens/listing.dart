import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/add_property.dart';

class MyListingPage extends StatelessWidget{
  const MyListingPage({Key? key}):super(key: key);

  @override
 Widget build(BuildContext context){
  final propertyListings =[
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': 'NGN2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
    },
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': 'NGN2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
    },
     {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': 'NGN2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
    },
    {
      'id':'1',
      'title': '3 Bedroom Apartment',
      'address': 'Akpajo Junction, Port Harcourt' ,
      'price': 'NGN2,000,000',
      'type': 'Apartment',
      'status': 'Active', 
      'image': 'https://placeholder.com/350x400',
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

class PropertyListingCard extends StatelessWidget{
  final Map<String, String> listing;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PropertyListingCard({
    Key?key,
    required this.listing,
    required this.onEdit,
    required this.onDelete,
  }):super(key: key);

  @override
 Widget build(BuildContext context){
  return Card(
    margin: const EdgeInsets.only(bottom: 16),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          color: Colors.grey[300],
          child: Center(
            child: Icon(Icons.home,
            size: 60,
            color: Colors.grey[600],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(
                  listing['status'] ??' ',
                  style: TextStyle(
                    color: listing['status']=='Active'?Colors.white:Colors.black87,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: listing['status']=='Active'
                ?Colors.green
                : listing['status'] == 'Pending'
                ?Colors.amber
                :Colors.grey,
                padding: const EdgeInsets.all(0),
              ),
              Text(
                listing['type']??'',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listing['title']??'',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                listing['address']??'',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                listing['price']??'',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                onPressed: onEdit,
              ),
              TextButton.icon(
                icon: const Icon(Icons.delete_outline, color: Colors.red,),
                label: const Text('Remove', style: TextStyle(color: Colors.red)),
                onPressed: onEdit,
              ),
            ],
          ),
        )
      ],
    ),
  );
 }
}