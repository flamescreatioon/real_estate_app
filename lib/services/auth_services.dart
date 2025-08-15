import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:real_estate_app/services/jsondb.dart';

enum UserRole { tenant, agent, admin, p2pClient }

class LocalUser {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final UserRole role;
  final String passwordHash;

  LocalUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.passwordHash,
    this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'phone': phone,
        'role': role.name,
        'password_hash': passwordHash,
      };

  factory LocalUser.fromJson(Map<String, dynamic> json) => LocalUser(
        id: json['id'] as String,
        email: json['email'] as String,
        fullName: json['full_name'] as String? ?? '',
        phone: json['phone'] as String?,
        role: UserRole.values.firstWhere(
          (r) => r.name == (json['role'] as String? ?? 'p2pClient'),
          orElse: () => UserRole.p2pClient,
        ),
        passwordHash: json['password_hash'] as String? ?? '',
      );
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _json = JsonDatabaseService.instance;
  LocalUser? _current;
  final ValueNotifier<LocalUser?> _authNotifier = ValueNotifier(null);
  static const _currentUserKey = 'current_user_id';

  // Stream-like accessor to mimic previous API
  ValueListenable<LocalUser?> get authStateChanges => _authNotifier;
  LocalUser? get currentUser => _current;

  Future<List<LocalUser>> _loadAllUsers() async {
    final data = await _json.getUserData();
    final list = (data['users'] as List?) ?? [];
    return list
        .whereType<Map>()
        .map((m) => LocalUser.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> restoreSessionIfAny() async {
    final data = await _json.getUserData();
    final savedId = data[_currentUserKey] as String?;
    if (savedId == null) return;
    final users = await _loadAllUsers();
    final u = users.firstWhere(
      (e) => e.id == savedId,
      orElse: () => LocalUser(
          id: '',
          email: '',
          fullName: '',
          passwordHash: '',
          role: UserRole.p2pClient),
    );
    if (u.id.isEmpty) return;
    _current = u;
    _authNotifier.value = _current;
  }

  Future<void> _persistUsers(List<LocalUser> users) async {
    final existing = await _json.getUserData();
    existing['users'] = users.map((u) => u.toJson()).toList();
    await _json.saveUserData(existing);
  }

  String _hashPassword(String plain) {
    final salt = 'static_salt_v1'; // For demo; replace with per-user salt.
    return sha256.convert(utf8.encode('$salt::$plain')).toString();
  }

  Future<LocalUser> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    UserRole role = UserRole.p2pClient,
  }) async {
    final users = await _loadAllUsers();
    if (users.any((u) => u.email.toLowerCase() == email.toLowerCase())) {
      throw AuthException('Email already registered');
    }
    final newUser = LocalUser(
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(999).toString(),
      email: email,
      fullName: fullName,
      phone: phone,
      role: role,
      passwordHash: _hashPassword(password),
    );
    users.add(newUser);
    await _persistUsers(users);
    // Persist current user id
    final data = await _json.getUserData();
    data[_currentUserKey] = newUser.id;
    await _json.saveUserData(data);
    _current = newUser;
    _authNotifier.value = _current;
    return newUser;
  }

  Future<LocalUser> signInWithEmail(String email, String password) async {
    final users = await _loadAllUsers();
    final hash = _hashPassword(password);
    final user = users.firstWhere(
      (u) =>
          u.email.toLowerCase() == email.toLowerCase() &&
          u.passwordHash == hash,
      orElse: () => throw AuthException('Invalid credentials'),
    );
    _current = user;
    final data = await _json.getUserData();
    data[_currentUserKey] = user.id;
    await _json.saveUserData(data);
    _authNotifier.value = _current;
    return user;
  }

  Future<void> resetPassword(String email) async {
    final users = await _loadAllUsers();
    final idx =
        users.indexWhere((u) => u.email.toLowerCase() == email.toLowerCase());
    if (idx == -1) throw AuthException('Email not found');
    // Demo: reset to 'password123'
    users[idx] = LocalUser(
      id: users[idx].id,
      email: users[idx].email,
      fullName: users[idx].fullName,
      phone: users[idx].phone,
      role: users[idx].role,
      passwordHash: _hashPassword('password123'),
    );
    await _persistUsers(users);
  }

  Future<void> signOut() async {
    _current = null;
    _authNotifier.value = null;
    final data = await _json.getUserData();
    data.remove(_currentUserKey);
    await _json.saveUserData(data);
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => 'AuthException: $message';
}
