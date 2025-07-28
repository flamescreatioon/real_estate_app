// providers/auth_provider.dart
import 'package:real_estate_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  UserProfile? _profile;
  bool _isLoading = false ;

  User? get user => _user;
  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _initAuthListener();
  }

  void _initAuthListener() {
    AuthService().authStateChanges.listen((AuthState state) async {
      _user = state.session?.user;
      if (_user != null) {
        await _loadUserProfile();
      } else {
        _profile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserProfile() async {
    if (_user == null) return;

    try {
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', _user!.id)
          .single();

      _profile = UserProfile.fromJson(response);
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await AuthService().signInWithEmail(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }
}
