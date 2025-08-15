import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Auth & core screens
import 'package:real_estate_app/screens/auth/login.dart';
import 'package:real_estate_app/screens/auth/signup.dart';
import 'package:real_estate_app/screens/auth/verification.dart';
import 'package:real_estate_app/screens/auth/welcome_screen.dart';
import 'package:real_estate_app/screens/auth/account_recovery.dart';
import 'package:real_estate_app/screens/home.dart';
import 'package:real_estate_app/screens/error_404.dart';
import 'package:real_estate_app/screens/notification.dart';
import 'package:real_estate_app/route/tab_shell.dart';
import 'package:real_estate_app/screens/chat/chat_screen.dart';
import 'package:real_estate_app/screens/profile/profile_screen.dart';
import 'package:real_estate_app/screens/dev/json_items_screen.dart';

// Property
import 'package:real_estate_app/screens/property/listing.dart';
import 'package:real_estate_app/screens/property/listing_detail.dart';
import 'package:real_estate_app/screens/property/add_property.dart';
import 'package:real_estate_app/screens/property/filters.dart';
import 'package:real_estate_app/screens/property/inquiries.dart';
import 'package:real_estate_app/screens/property/inquiries_detail.dart';
import 'package:real_estate_app/screens/property/confirmation.dart';
import 'package:real_estate_app/screens/property/dispute.dart';
import 'package:real_estate_app/screens/property/request.dart' as prop_req;

// Payments
import 'package:real_estate_app/screens/payment/payment_summary.dart';
import 'package:real_estate_app/screens/payment/transactions.dart' as pay_tx;

// Access the same compile-time flag used in main.dart (duplicate here if needed)
const bool kUseSupabase = bool.fromEnvironment('USE_SUPABASE');

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const Error404Screen(),
  redirect: (context, state) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = auth.isAuthenticated;
    final goingToLogin = state.matchedLocation == '/login';
    final goingToRegister = state.matchedLocation == '/register';
    final goingToVerify = state.matchedLocation == '/verify';

    // If logged in and hitting login/register -> send to dashboard
    if (loggedIn && (goingToLogin || goingToRegister)) return '/dashboard';

    // Require auth for certain protected routes
    final protectedPrefixes = [
      '/dashboard',
      '/listings',
      '/chat',
      '/profile',
      '/add-property'
    ];
    final isProtected =
        protectedPrefixes.any((p) => state.matchedLocation.startsWith(p));
    if (!loggedIn && isProtected) return '/login';

    // Supabase email verification handling
    if (kUseSupabase && loggedIn) {
      final user = Supabase.instance.client.auth.currentUser;
      final emailConfirmed = user?.emailConfirmedAt != null;
      if (!emailConfirmed && !goingToVerify) {
        return '/verify';
      }
      if (emailConfirmed && goingToVerify) {
        // If already verified, don't stay on verify page
        return '/dashboard';
      }
    }
    return null; // no redirect
  },
  routes: [
    // Public & auth routes
    GoRoute(
      path: '/',
      builder: (context, state) =>
          DashboardPage(userType: 'Buyer', userName: 'Ugochukwu'),
    ),
    GoRoute(
        path: '/welcome', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const SignUpPage()),
    GoRoute(
        path: '/verify', builder: (context, state) => const VerificationPage()),
    GoRoute(
        path: '/account-recovery',
        builder: (context, state) => RecoveryOptionsScreen()),

    // Shell with bottom navigation
    ShellRoute(
      builder: (context, state, child) => TabShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) =>
              DashboardPage(userType: 'Buyer', userName: 'Ugochukwu'),
        ),
        GoRoute(
            path: '/listings', builder: (context, state) => MyListingPage()),
        GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
        GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen()),
      ],
    ),

    // Property detail & related (outside shell to allow full-screen push)
    GoRoute(
      path: '/property/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PropertyDetailsScreen(
          propertyId: int.tryParse(id) ?? 0,
          propertyType: '',
          price: 0.0,
          address: '',
          bedrooms: 0,
          bathrooms: 0,
          sqft: 0,
          imageUrl: '',
        );
      },
    ),
    GoRoute(
        path: '/add-property',
        builder: (context, state) =>
            const AddEditPropertyPage(propertyData: {})),
    GoRoute(
        path: '/filters', builder: (context, state) => SearchFiltersScreen()),
    GoRoute(
        path: '/inquiries',
        builder: (context, state) => const InquiriesScreen()),
    GoRoute(
        path: '/inquiries/detail', builder: (context, state) => InquiryPage()),
    GoRoute(
        path: '/confirmation',
        builder: (context, state) => const ConfirmationPage()),
    GoRoute(path: '/dispute', builder: (context, state) => const DisputePage()),

    // Notifications
    GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen()),

    // Payments
    GoRoute(
        path: '/payment/summary',
        builder: (context, state) => const SecurePaymentPage()),
    GoRoute(
        path: '/payment/transactions',
        builder: (context, state) => const pay_tx.TransactionsScreen()),

    // Property related (renamed requests screen)
    GoRoute(
        path: '/property/requests',
        builder: (context, state) => const prop_req.PropertyRequestsScreen()),

    // Dev / JSON sample viewer
    GoRoute(
        path: '/json-items',
        builder: (context, state) => const JsonItemsScreen()),
  ],
);
