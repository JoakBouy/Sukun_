class SessionNote {
  final String id;
  final String appointmentId;
  final String doctorId;
  final String patientId;
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;
  final DateTime createdAt;
  final bool isSynced;

  const SessionNote({
    required this.id,
    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.subjective,
    required this.objective,
    required this.assessment,
    required this.plan,
    required this.createdAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_id': appointmentId,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'subjective': subjective,
      'objective': objective,
      'assessment': assessment,
      'plan': plan,
      'created_at': createdAt.millisecondsSinceEpoch,
      'is_synced': isSynced ? 1 : 0,
    };
  }

  factory SessionNote.fromJson(Map<String, dynamic> json) {
    return SessionNote(
      id: json['id'] as String,
      appointmentId: json['appointment_id'] as String,
      doctorId: json['doctor_id'] as String,
      patientId: json['patient_id'] as String,
      subjective: json['subjective'] as String,
      objective: json['objective'] as String,
      assessment: json['assessment'] as String,
      plan: json['plan'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      isSynced: (json['is_synced'] as int) == 1,
    );
  }

  SessionNote copyWith({
    String? id,
    String? appointmentId,
    String? doctorId,
    String? patientId,
    String? subjective,
    String? objective,
    String? assessment,
    String? plan,
    DateTime? createdAt,
    bool? isSynced,
  }) {
    return SessionNote(
      id: id ?? this.id,
      appointmentId: appointmentId ?? this.appointmentId,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      subjective: subjective ?? this.subjective,
      objective: objective ?? this.objective,
      assessment: assessment ?? this.assessment,
      plan: plan ?? this.plan,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
