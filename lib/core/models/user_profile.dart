import 'package:freud_ai/core/models/user_role.dart';

enum LicenseStatus {
  pending,
  verified,
  rejected,
}

extension LicenseStatusExtension on LicenseStatus {
  String get displayName {
    switch (this) {
      case LicenseStatus.pending:
        return 'Pending Verification';
      case LicenseStatus.verified:
        return 'Verified';
      case LicenseStatus.rejected:
        return 'Rejected';
    }
  }

  String get value {
    switch (this) {
      case LicenseStatus.pending:
        return 'pending';
      case LicenseStatus.verified:
        return 'verified';
      case LicenseStatus.rejected:
        return 'rejected';
    }
  }

  static LicenseStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'verified':
        return LicenseStatus.verified;
      case 'rejected':
        return LicenseStatus.rejected;
      case 'pending':
      default:
        return LicenseStatus.pending;
    }
  }
}

class UserProfile {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String? profileImageUrl;
  
  // Doctor-specific fields
  final String? licenseNumber;
  final LicenseStatus? licenseStatus;
  final String? specialization;
  final int? yearsOfExperience;
  final String? bio;
  final double? hourlyRate;
  
  // Timestamps
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profileImageUrl,
    this.licenseNumber,
    this.licenseStatus,
    this.specialization,
    this.yearsOfExperience,
    this.bio,
    this.hourlyRate,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isDoctor => role == UserRole.doctor;
  bool get isAdmin => role == UserRole.admin;
  bool get isPatient => role == UserRole.patient;
  bool get isVerifiedDoctor => isDoctor && licenseStatus == LicenseStatus.verified;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.value,
      'profileImageUrl': profileImageUrl,
      'licenseNumber': licenseNumber,
      'licenseStatus': licenseStatus?.value,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
      'bio': bio,
      'hourlyRate': hourlyRate,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: UserRoleExtension.fromString(json['role'] as String? ?? 'patient'),
      profileImageUrl: json['profileImageUrl'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      licenseStatus: json['licenseStatus'] != null
          ? LicenseStatusExtension.fromString(json['licenseStatus'] as String)
          : null,
      specialization: json['specialization'] as String?,
      yearsOfExperience: json['yearsOfExperience'] as int?,
      bio: json['bio'] as String?,
      hourlyRate: json['hourlyRate'] as double?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      updatedAt: json['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int)
          : null,
    );
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    String? profileImageUrl,
    String? licenseNumber,
    LicenseStatus? licenseStatus,
    String? specialization,
    int? yearsOfExperience,
    String? bio,
    double? hourlyRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      specialization: specialization ?? this.specialization,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      bio: bio ?? this.bio,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
