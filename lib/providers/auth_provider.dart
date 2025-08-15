// providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:real_estate_app/services/auth_repository.dart';
import 'package:real_estate_app/services/auth_services.dart'
    as local_backend; // for role enum mapping
import 'package:supabase_flutter/supabase_flutter.dart';

// Toggle via --dart-define=USE_SUPABASE=true
const bool kUseSupabase = bool.fromEnvironment('USE_SUPABASE');

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;
  UserAccount? _user;
  bool _isLoading = false;
  String? _error;

  UserAccount? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  String? get error => _error;
  AuthProvider({AuthRepository? repository})
      : _repo = repository ?? _defaultRepository() {
    _repo.authStateChanges.addListener(() {
      _user = _repo.currentUser;
      notifyListeners();
    });
  }

  static AuthRepository _defaultRepository() {
    if (kUseSupabase) {
      final client = Supabase.instance.client;
      return SupabaseAuthRepository(client);
    }
    return LocalAuthRepository();
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repo.signIn(email, password);
    } on Exception catch (e) {
      _error = e.toString();
    } catch (e) {
      _error = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }

  Future<void> signInWithProvider(String provider) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _repo.signInWithProvider(provider);
    } on Exception catch (e) {
      _error = e.toString();
    } catch (e) {
      _error = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    local_backend.UserRole role = local_backend.UserRole.p2pClient,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _repo.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        role: role.name,
      );
    } on Exception catch (e) {
      _error = e.toString();
    } catch (e) {
      _error = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _repo.resetPassword(email);
    } on Exception catch (e) {
      _error = e.toString();
    } catch (e) {
      _error = 'Unexpected error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
