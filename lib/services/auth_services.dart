
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final SupabaseClient _supabase = Supabase.instance.client;

  // Email/Password Registration
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    UserRole role = UserRole.p2pClient,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
          'role': role.name,
        },
      );
      
      if (response.user != null) {
        await _createUserProfile(response.user!, fullName, phone, role);
      }
      
      return response;
    } catch (e) {
      throw AuthException('Registration failed: ${e.toString()}');
    }
  }

  // Email/Password Sign In
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Phone Authentication
  Future<void> signInWithPhone(String phone) async {
    await _supabase.auth.signInWithOtp(phone: phone);
  }

  Future<AuthResponse> verifyPhoneOtp(String phone, String token) async {
    return await _supabase.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }

  // Social Authentication
  Future<bool> signInWithGoogle() async {
    return await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'your-app://auth-callback',
    );
  }

  Future<bool> signInWithApple() async {
    return await _supabase.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'your-app://auth-callback',
    );
  }

  // Password Reset
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'your-app://reset-password',
    );
  }

  // Sign Out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Current User
  User? get currentUser => _supabase.auth.currentUser;
  
  // Auth State Stream
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Private helper
  Future<void> _createUserProfile(
    User user, 
    String fullName, 
    String? phone, 
    UserRole role
  ) async {
    await _supabase.from('profiles').insert({
      'id': user.id,
      'email': user.email,
      'full_name': fullName,
      'phone': phone,
      'role': role.name,
    });
  }
}

enum UserRole { tenant, agent, admin, p2pClient }