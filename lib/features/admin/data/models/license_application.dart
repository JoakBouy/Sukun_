class LicenseApplication {
  final String id;
  final String userId;
  final String doctorName;
  final String email;
  final String licenseNumber;
  final String specialization;
  final int yearsOfExperience;
  final String status; // pending, verified, rejected
  final String? documentUrl;
  final String? rejectionReason;
  final DateTime submittedAt;
  final DateTime? reviewedAt;

  const LicenseApplication({
    required this.id,
    required this.userId,
    required this.doctorName,
    required this.email,
    required this.licenseNumber,
    required this.specialization,
    required this.yearsOfExperience,
    required this.status,
    this.documentUrl,
    this.rejectionReason,
    required this.submittedAt,
    this.reviewedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_name': doctorName,
      'email': email,
      'license_number': licenseNumber,
      'specialization': specialization,
      'years_of_experience': yearsOfExperience,
      'status': status,
      'document_url': documentUrl,
      'rejection_reason': rejectionReason,
      'submitted_at': submittedAt.millisecondsSinceEpoch,
      'reviewed_at': reviewedAt?.millisecondsSinceEpoch,
    };
  }

  factory LicenseApplication.fromJson(Map<String, dynamic> json) {
    return LicenseApplication(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      doctorName: json['doctor_name'] as String,
      email: json['email'] as String,
      licenseNumber: json['license_number'] as String,
      specialization: json['specialization'] as String,
      yearsOfExperience: json['years_of_experience'] as int,
      status: json['status'] as String,
      documentUrl: json['document_url'] as String?,
      rejectionReason: json['rejection_reason'] as String?,
      submittedAt: DateTime.fromMillisecondsSinceEpoch(json['submitted_at'] as int),
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['reviewed_at'] as int)
          : null,
    );
  }

  bool get isPending => status == 'pending';
  bool get isVerified => status == 'verified';
  bool get isRejected => status == 'rejected';
}
