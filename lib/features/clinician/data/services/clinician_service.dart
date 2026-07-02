import 'package:uuid/uuid.dart';
import 'package:freud_ai/features/clinician/data/local/clinician_database.dart';
import 'package:freud_ai/features/clinician/data/models/client_session.dart';
import 'package:freud_ai/features/clinician/data/models/outreach_event.dart';

const _uuid = Uuid();

/// Service layer for all Primetel clinician data operations.
/// Uses the local SQLite database for fully offline operation.
class ClinicianService {
  static final ClinicianService instance = ClinicianService._();
  ClinicianService._();

  final _db = ClinicianDatabase.instance;

  // ── Sessions ──────────────────────────────────────────────────────────────

  Future<void> saveSession(ClientSession session) async {
    await _db.insertSession(session.toMap());
  }

  Future<ClientSession> createAndSaveSession({
    required String clientIdentifier,
    required bool isAnonymous,
    String? gender,
    String? ageRange,
    required bool isFirstVisit,
    required String sessionContext,
    String? subLocation,
    required String assessmentType,
    required int score,
    required String severity,
    required Map<int, String> answers,
    String? clinicianNotes,
    required bool crisisFlag,
    String? referralMade,
    String? followUpDate,
  }) async {
    final session = ClientSession(
      id: _uuid.v4(),
      clientIdentifier: clientIdentifier,
      isAnonymous: isAnonymous,
      gender: gender,
      ageRange: ageRange,
      isFirstVisit: isFirstVisit,
      sessionContext: sessionContext,
      subLocation: subLocation,
      assessmentType: assessmentType,
      score: score,
      severity: severity,
      answers: answers,
      clinicianNotes: clinicianNotes,
      crisisFlag: crisisFlag,
      timestamp: DateTime.now(),
      referralMade: referralMade,
      followUpDate: followUpDate,
    );
    await _db.insertSession(session.toMap());
    return session;
  }

  Future<List<ClientSession>> getSessionsByClient(String clientId) async {
    final maps = await _db.getSessionsByClient(clientId);
    return maps.map(ClientSession.fromMap).toList();
  }

  Future<List<ClientSession>> getRecentSessions({int limit = 10}) async {
    final maps = await _db.getAllSessions(limit: limit);
    return maps.map(ClientSession.fromMap).toList();
  }

  Future<List<ClientSession>> getTodaysSessions() async {
    final maps = await _db.getTodaysSessions();
    return maps.map(ClientSession.fromMap).toList();
  }

  Future<List<ClientSession>> getCrisisSessions() async {
    final maps = await _db.getCrisisSessions();
    return maps.map(ClientSession.fromMap).toList();
  }

  Future<List<Map<String, dynamic>>> getAllClients() async {
    return _db.getAllClients();
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    return _db.getDashboardStats();
  }

  /// Score delta between last two assessments of the same type for a client.
  /// Returns null if fewer than 2 assessments exist.
  Future<int?> getScoreDelta(String clientId, String assessmentType) async {
    final sessions = await getSessionsByClient(clientId);
    final ofType = sessions.where((s) => s.assessmentType == assessmentType).toList();
    if (ofType.length < 2) return null;
    return ofType[1].score - ofType[0].score; // positive = worsened, negative = improved
  }

  // ── Outreach Events ───────────────────────────────────────────────────────

  Future<void> saveOutreachEvent(OutreachEvent event) async {
    await _db.insertOutreachEvent(event.toMap());
  }

  Future<OutreachEvent> createOutreachEvent({
    required String eventType,
    required String location,
    double? latitude,
    double? longitude,
    required int peopleReached,
    required int referralsMade,
    String? notes,
  }) async {
    final event = OutreachEvent(
      id: _uuid.v4(),
      eventType: eventType,
      location: location,
      latitude: latitude,
      longitude: longitude,
      peopleReached: peopleReached,
      referralsMade: referralsMade,
      notes: notes,
      date: DateTime.now(),
    );
    await _db.insertOutreachEvent(event.toMap());
    return event;
  }

  Future<List<OutreachEvent>> getOutreachEvents() async {
    final maps = await _db.getOutreachEvents();
    return maps.map(OutreachEvent.fromMap).toList();
  }

  Future<Map<String, dynamic>> getOutreachStats() async {
    return _db.getOutreachStats();
  }

  // ── Safety Plans ──────────────────────────────────────────────────────────

  Future<void> saveSafetyPlan({
    required String clientId,
    required String warningSigns,
    required String internalCoping,
    required String socialDistractions,
    required String peopleToContact,
    required String professionalsToCall,
    required String meansRestriction,
    String? clinicianName,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.upsertSafetyPlan({
      'id': _uuid.v4(),
      'client_identifier': clientId,
      'warning_signs': warningSigns,
      'internal_coping': internalCoping,
      'social_distractions': socialDistractions,
      'people_to_contact': peopleToContact,
      'professionals_to_call': professionalsToCall,
      'means_restriction': meansRestriction,
      'clinician_name': clinicianName,
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<Map<String, dynamic>?> getSafetyPlan(String clientId) async {
    return _db.getSafetyPlan(clientId);
  }

  // ── SOAP Notes ────────────────────────────────────────────────────────────

  Future<void> saveSoapNote({
    required String clientId,
    required String subjective,
    required String objective,
    required String assessment,
    required String plan,
    String? sessionContext,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.insertSoapNote({
      'id': _uuid.v4(),
      'client_identifier': clientId,
      'subjective': subjective,
      'objective': objective,
      'assessment': assessment,
      'plan': plan,
      'session_context': sessionContext,
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<List<Map<String, dynamic>>> getSoapNotes(String clientId) async {
    return _db.getSoapNotes(clientId);
  }

  Future<List<Map<String, dynamic>>> getAllClientNotes() async {
    return _db.getAllSoapNotes();
  }

  // ── Group Sessions ────────────────────────────────────────────────────────

  Future<void> saveGroupSession({
    required String groupName,
    required String sessionType,
    required String context,
    String? location,
    required int participants,
    required String topicsCovered,
    required int referralsMade,
    String? notes,
  }) async {
    await _db.insertGroupSession({
      'id': _uuid.v4(),
      'group_name': groupName,
      'session_type': sessionType,
      'context': context,
      'location': location,
      'participants': participants,
      'topics_covered': topicsCovered,
      'referrals_made': referralsMade,
      'notes': notes,
      'date': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getGroupSessions() async {
    return _db.getGroupSessions();
  }

  // ── Analytics ─────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getSeverityDistribution() async {
    return _db.getSeverityDistribution();
  }

  /// Generates a formatted text report for copy/paste into referral documents
  String generateReferralText({
    required String clientIdentifier,
    required String assessmentType,
    required int score,
    required String severity,
    required String clinicianName,
    required String clinicName,
    String? additionalNotes,
  }) {
    final date = DateTime.now();
    final dateStr = '${date.day}/${date.month}/${date.year}';
    return '''
MENTAL HEALTH REFERRAL LETTER
Primetel Health — $clinicName
Date: $dateStr

To Whom It May Concern,

I am writing to refer my patient, $clientIdentifier, for further mental health assessment and management.

ASSESSMENT FINDINGS:
• Assessment Tool: $assessmentType
• Score: $score
• Clinical Severity: $severity

${additionalNotes != null ? 'CLINICAL NOTES:\n$additionalNotes\n' : ''}
This client requires prompt attention based on their assessment results. I request that they be seen at the earliest opportunity.

Referring Clinician: $clinicianName
Organization: Primetel Health
Location: Monduli, Arusha, Tanzania

---
This referral was generated using the Primetel Health Assessment Platform.
''';
  }

  /// Generates a monthly impact report text
  Future<String> generateMonthlyReport({required String clinicianName}) async {
    final stats = await getDashboardStats();
    final outreachStats = await getOutreachStats();
    final crisisSessions = await getCrisisSessions();
    final severityDist = await getSeverityDistribution();
    final now = DateTime.now();
    final monthNames = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final severitySummary = severityDist.map((s) =>
      '  • ${s['assessment_type']} - ${s['severity']}: ${s['count']} cases'
    ).join('\n');

    return '''
PRIMETEL HEALTH — MONTHLY IMPACT REPORT
${monthNames[now.month]} ${now.year}
Prepared by: $clinicianName

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CLINICAL ACTIVITY (This Month)
• Individual assessments completed: ${stats['this_month']}
• Total clients in system: ${stats['total_clients']}
• Crisis flags this week: ${stats['crisis_flags']}

OUTREACH & COMMUNITY
• Outreach events this month: ${outreachStats['total_events'] ?? 0}
• People reached: ${outreachStats['total_reached'] ?? 0}
• Referrals made: ${outreachStats['total_referrals'] ?? 0}

SEVERITY DISTRIBUTION (Last 90 Days)
$severitySummary

CRISIS MANAGEMENT
• Total high-risk cases managed: ${crisisSessions.length}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Generated by Primetel Health Assessment Platform
Monduli, Arusha, Tanzania
''';
  }
}
