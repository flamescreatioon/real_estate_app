import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
// Removed unused widget/screen imports (routing handled by GoRouter config)
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:real_estate_app/route/app_router.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/providers/auth_provider.dart';
import 'package:real_estate_app/services/jsondb.dart';
import 'package:real_estate_app/services/auth_services.dart';

// Enable Supabase via --dart-define=USE_SUPABASE=true
const bool kUseSupabase = bool.fromEnvironment('USE_SUPABASE');

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await dotenv.load(fileName: "lib/env/public_env.env");
  if (kUseSupabase) {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  // Initialize local JSON database files (without sample data by default)
  await JsonDatabaseService.instance.ensureInitialized(withSampleData: true);
  // Restore local session if using local backend
  if (!kUseSupabase) {
    await AuthService().restoreSessionIfAny();
  }

  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  ));
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
