import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:real_estate_app/screens/add_property.dart';
import 'screens/listing.dart';
import 'screens/welcome_screen.dart'; // Importing the WelcomeScreen class
// Removed unnecessary import as 'flutter/material.dart' already includes 'flutter/widgets.dart'.

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(
    DevicePreview(
      enabled: true, // Replace 'kReleaseMode' with a valid boolean value or define 'kReleaseMode'.
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property P2P App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false, // Moved to the correct location.
      home: const WelcomeScreen(), // Set the initial screen to WelcomeScreen
      
      routes: {
        '/listing': (context) => const MyListingPage(),
        '/add_property': (context) => const AddEditPropertyPage(propertyData: {}),
      }, // Your app's home screen
    );
  }
}

