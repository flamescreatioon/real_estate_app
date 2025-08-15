import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:real_estate_app/services/auth_services.dart' as local;

class UserAccount {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String role;
  const UserAccount({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
  });
}

abstract class AuthRepository {
  ValueListenable<UserAccount?> get authStateChanges;
  UserAccount? get currentUser;
  Future<UserAccount> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String role,
  });
  Future<UserAccount> signIn(String email, String password);
  // Optional social / oauth provider sign-in. Implementations that do not
  // support this should throw an [UnsupportedError]. Provider examples:
  // 'google', 'apple'.
  Future<void> signInWithProvider(String provider);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}

class LocalAuthRepository implements AuthRepository {
  final local.AuthService _svc = local.AuthService();
  final ValueNotifier<UserAccount?> _notifier = ValueNotifier(null);
  LocalAuthRepository() {
    _svc.authStateChanges.addListener(() {
      final u = _svc.currentUser;
      _notifier.value = u == null
          ? null
          : UserAccount(
              id: u.id,
              email: u.email,
              fullName: u.fullName,
              phone: u.phone,
              role: u.role.name,
            );
    });
  }
  @override
  ValueListenable<UserAccount?> get authStateChanges => _notifier;
  @override
  UserAccount? get currentUser => _notifier.value;
  @override
  Future<void> resetPassword(String email) => _svc.resetPassword(email);
  @override
  Future<UserAccount> signIn(String email, String password) async {
    final u = await _svc.signInWithEmail(email, password);
    return UserAccount(
      id: u.id,
      email: u.email,
      fullName: u.fullName,
      phone: u.phone,
      role: u.role.name,
    );
  }

  @override
  Future<void> signInWithProvider(String provider) async {
    throw UnsupportedError('Social sign-in not supported for local auth');
  }

  @override
  Future<void> signOut() => _svc.signOut();
  @override
  Future<UserAccount> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String role = 'p2pClient',
  }) async {
    final u = await _svc.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      role: local.UserRole.values.firstWhere(
        (r) => r.name == role,
        orElse: () => local.UserRole.p2pClient,
      ),
    );
    return UserAccount(
      id: u.id,
      email: u.email,
      fullName: u.fullName,
      phone: u.phone,
      role: u.role.name,
    );
  }
}

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;
  final ValueNotifier<UserAccount?> _notifier = ValueNotifier(null);
  late final StreamSubscription<AuthState> _sub;
  SupabaseAuthRepository(this._client) {
    final user = _client.auth.currentUser;
    if (user != null) _notifier.value = _mapUser(user);
    _sub = _client.auth.onAuthStateChange.listen((event) {
      final usr = event.session?.user;
      _notifier.value = usr == null ? null : _mapUser(usr);
    });
  }
  UserAccount _mapUser(User user) {
    final md = user.userMetadata ?? {};
    return UserAccount(
      id: user.id,
      email: user.email ?? '',
      fullName: (md['full_name'] as String?) ?? (user.email ?? ''),
      phone: md['phone'] as String?,
      role: (md['role'] as String?) ?? 'user',
    );
  }

  @override
  ValueListenable<UserAccount?> get authStateChanges => _notifier;
  @override
  UserAccount? get currentUser => _notifier.value;
  @override
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email, redirectTo: null);
  }

  @override
  Future<UserAccount> signIn(String email, String password) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user;
    if (user == null) throw Exception('Sign in failed');
    final acc = _mapUser(user);
    _notifier.value = acc;
    return acc;
  }

  @override
  Future<void> signInWithProvider(String provider) async {
    OAuthProvider? prov;
    switch (provider.toLowerCase()) {
      case 'google':
        prov = OAuthProvider.google;
        break;
      case 'apple':
        prov = OAuthProvider.apple;
        break;
      default:
        throw UnsupportedError('Provider $provider not supported');
    }
    await _client.auth.signInWithOAuth(prov);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
    _notifier.value = null;
  }

  @override
  Future<UserAccount> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String role = 'user',
  }) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'phone': phone,
        'role': role,
      },
    );
    final user = res.user;
    if (user == null) throw Exception('Sign up failed');
    final acc = _mapUser(user);
    _notifier.value = acc;
    return acc;
  }

  void dispose() {
    _sub.cancel();
  }
}
