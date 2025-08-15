class UserProfile {
  final String id;
  final String? email;
  final String? fullName;
  final String? phone;
  final String? role;

  UserProfile({
    required this.id,
    this.email,
    this.fullName,
    this.phone,
    this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'phone': phone,
        'role': role,
      };
}
