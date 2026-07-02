import 'dart:convert';

/// Represents a single mental health assessment session conducted by a
/// Primetel Health psychologist for a specific client.
class ClientSession {
  final String id;
  final String clientIdentifier; // Name or anonymous code
  final bool isAnonymous;
  final String? gender; // 'Male', 'Female', 'Other', 'Prefer not to say'
  final String? ageRange; // '<18', '18-25', '26-35', '36-50', '50+'
  final bool isFirstVisit;
  final String sessionContext; // 'Clinic', 'Outreach', 'School', 'Workplace', 'Home Visit'
  final String? subLocation; // specific village, school name, company name
  final String assessmentType; // 'PHQ9', 'GAD7', 'DASS21', 'ASQ', 'PCL5', 'SRQ20'
  final int score;
  final String severity; // e.g. 'Minimal', 'Mild', 'Moderate', 'Severe'
  final Map<int, String> answers; // question index → selected answer
  final String? clinicianNotes;
  final bool crisisFlag; // true if ASQ high risk or PHQ-9 Q9 endorsed
  final DateTime timestamp;
  final String? referralMade; // who was referred to
  final String? followUpDate; // ISO date string

  const ClientSession({
    required this.id,
    required this.clientIdentifier,
    required this.isAnonymous,
    this.gender,
    this.ageRange,
    required this.isFirstVisit,
    required this.sessionContext,
    this.subLocation,
    required this.assessmentType,
    required this.score,
    required this.severity,
    required this.answers,
    this.clinicianNotes,
    required this.crisisFlag,
    required this.timestamp,
    this.referralMade,
    this.followUpDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_identifier': clientIdentifier,
      'is_anonymous': isAnonymous ? 1 : 0,
      'gender': gender,
      'age_range': ageRange,
      'is_first_visit': isFirstVisit ? 1 : 0,
      'session_context': sessionContext,
      'sub_location': subLocation,
      'assessment_type': assessmentType,
      'score': score,
      'severity': severity,
      'answers': jsonEncode(answers.map((k, v) => MapEntry(k.toString(), v))),
      'clinician_notes': clinicianNotes,
      'crisis_flag': crisisFlag ? 1 : 0,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'referral_made': referralMade,
      'follow_up_date': followUpDate,
    };
  }

  factory ClientSession.fromMap(Map<String, dynamic> map) {
    final rawAnswers = map['answers'] as String? ?? '{}';
    final decoded = jsonDecode(rawAnswers) as Map<String, dynamic>;
    final answers = decoded.map((k, v) => MapEntry(int.parse(k), v as String));

    return ClientSession(
      id: map['id'] as String,
      clientIdentifier: map['client_identifier'] as String,
      isAnonymous: (map['is_anonymous'] as int) == 1,
      gender: map['gender'] as String?,
      ageRange: map['age_range'] as String?,
      isFirstVisit: (map['is_first_visit'] as int) == 1,
      sessionContext: map['session_context'] as String,
      subLocation: map['sub_location'] as String?,
      assessmentType: map['assessment_type'] as String,
      score: map['score'] as int,
      severity: map['severity'] as String,
      answers: answers,
      clinicianNotes: map['clinician_notes'] as String?,
      crisisFlag: (map['crisis_flag'] as int) == 1,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      referralMade: map['referral_made'] as String?,
      followUpDate: map['follow_up_date'] as String?,
    );
  }

  ClientSession copyWith({
    String? id,
    String? clientIdentifier,
    bool? isAnonymous,
    String? gender,
    String? ageRange,
    bool? isFirstVisit,
    String? sessionContext,
    String? subLocation,
    String? assessmentType,
    int? score,
    String? severity,
    Map<int, String>? answers,
    String? clinicianNotes,
    bool? crisisFlag,
    DateTime? timestamp,
    String? referralMade,
    String? followUpDate,
  }) {
    return ClientSession(
      id: id ?? this.id,
      clientIdentifier: clientIdentifier ?? this.clientIdentifier,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      gender: gender ?? this.gender,
      ageRange: ageRange ?? this.ageRange,
      isFirstVisit: isFirstVisit ?? this.isFirstVisit,
      sessionContext: sessionContext ?? this.sessionContext,
      subLocation: subLocation ?? this.subLocation,
      assessmentType: assessmentType ?? this.assessmentType,
      score: score ?? this.score,
      severity: severity ?? this.severity,
      answers: answers ?? this.answers,
      clinicianNotes: clinicianNotes ?? this.clinicianNotes,
      crisisFlag: crisisFlag ?? this.crisisFlag,
      timestamp: timestamp ?? this.timestamp,
      referralMade: referralMade ?? this.referralMade,
      followUpDate: followUpDate ?? this.followUpDate,
    );
  }

  /// Returns a color hex string based on severity level
  static String severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'minimal':
      case 'normal':
      case 'low risk':
        return '#9BB168';
      case 'mild':
      case 'moderate risk':
        return '#FFBD1A';
      case 'moderate':
      case 'elevated risk':
        return '#ED7E1C';
      case 'moderately severe':
      case 'severe':
      case 'high risk':
        return '#C82828';
      case 'extremely severe':
        return '#8B1A1A';
      default:
        return '#736B66';
    }
  }
}
