import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import all your screens
import 'package:real_estate_app/screens/auth/login.dart';
import 'package:real_estate_app/screens/auth/signup.dart';
import 'package:real_estate_app/screens/auth/verification.dart';
import 'package:real_estate_app/screens/auth/welcome_screen.dart';
import 'package:real_estate_app/screens/auth/account_recovery.dart';
import 'package:real_estate_app/screens/home.dart';
import 'package:real_estate_app/screens/error_404.dart';

import 'package:real_estate_app/screens/property/listing.dart';
import 'package:real_estate_app/screens/property/listing_detail.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const Error404Screen(),
  routes: [
    //First Screen
    GoRoute(
        path: '/',
        builder: (context, state) =>
            DashboardPage(userType: 'Buyer', userName: 'Ugochukwu')),
    //auth
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const SignUpPage()),
    GoRoute(
        path: '/verify', builder: (context, state) => const VerificationPage()),
    GoRoute(
        path: '/account-recovery',
        builder: (context, state) => RecoveryOptionsScreen()),

    //properties
    GoRoute(path: '/listings', builder: (context, state) => MyListingPage()),
    GoRoute(
        path: '/property/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PropertyDetailsScreen(
            propertyId: int.parse(id),
            propertyType: '',
            price: 0.0,
            address: '',
            bedrooms: 0,
            bathrooms: 0,
            sqft: 0,
            imageUrl: '',
          );
        })
  ],
  /*  initialLocation: '/welcome',
  errorBuilder: (context, state) => const Error404Screen(),
  routes: [
    // 🔐 Auth
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/verify', builder: (context, state) => const VerifyScreen()),

    // 🏠 Home Dashboard
    GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen()),

    // 🏘️ Properties
    GoRoute(
        path: '/listings', builder: (context, state) => const ListingsScreen()),
    GoRoute(
        path: '/property/:id',
        builder: (context, state) {
          final id = state.params['id']!;
          return PropertyDetailScreen(propertyId: id);
        }),
    GoRoute(
        path: '/add-property',
        builder: (context, state) => const AddPropertyScreen()),

    // 💬 Chat
    GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),

    // 🤝 P2P
    GoRoute(
        path: '/p2p', builder: (context, state) => const P2PDashboardScreen()),
    GoRoute(
        path: '/p2p/initiate',
        builder: (context, state) => const InitiateTransactionScreen()),
    GoRoute(
        path: '/p2p/transaction/:id',
        builder: (context, state) {
          final id = state.params['id']!;
          return TransactionDetailScreen(transactionId: id);
        }),

    // 💳 Payments
    GoRoute(
        path: '/escrow/:transactionId',
        builder: (context, state) {
          final id = state.params['transactionId']!;
          return EscrowScreen(transactionId: id);
        }),

    // ⚙️ Admin
    GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen()),

    // 👤 Profile
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()), 
  ],*/
);
