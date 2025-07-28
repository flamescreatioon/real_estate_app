import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate_app/route/app_router.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/auth/login.dart';
import 'screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/route/app_router.dart';
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await dotenv.load(fileName: "lib/env/public_env.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    DevicePreview(
      enabled:
          true, // Replace 'kReleaseMode' with a valid boolean value or define 'kReleaseMode'.
      builder: (context) => const MyApp(), // Wrap your app
    ),
    
  );
  // runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
     routerConfig: router,

      /*  initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(), 
      }*/ // Your app's home screen
    );
  }
}
