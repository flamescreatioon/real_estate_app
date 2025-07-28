import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:real_estate_app/services/auth_services.dart';

// services/role_guard_service.dart
class RoleGuardService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  static Future<UserRole?> getCurrentUserRole() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single();

    return UserRole.values.firstWhere(
      (role) => role.name == response['role'],
      orElse: () => UserRole.p2pClient,
    );
  }

  static Future<bool> hasRole(List<UserRole> allowedRoles) async {
    final currentRole = await getCurrentUserRole();
    return currentRole != null && allowedRoles.contains(currentRole);
  }

  static Future<bool> isAgent() async => hasRole([UserRole.agent]);
  static Future<bool> isAdmin() async => hasRole([UserRole.admin]);
  static Future<bool> isTenant() async => hasRole([UserRole.tenant]);
}