import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Extended database helper for the Primetel Health clinician portal.
/// Adds clinical tables on top of the existing schema.
class ClinicianDatabase {
  static final ClinicianDatabase instance = ClinicianDatabase._init();
  static Database? _database;

  ClinicianDatabase._init();

  Future<Database> get database async {
    if (kIsWeb) throw UnsupportedError('SQLite not supported on Web');
    if (_database != null) return _database!;
    _database = await _initDB('primetel_clinician.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // ── Client Sessions ──────────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE client_sessions (
        id TEXT PRIMARY KEY,
        client_identifier TEXT NOT NULL,
        is_anonymous INTEGER NOT NULL DEFAULT 0,
        gender TEXT,
        age_range TEXT,
        is_first_visit INTEGER NOT NULL DEFAULT 1,
        session_context TEXT NOT NULL,
        sub_location TEXT,
        assessment_type TEXT NOT NULL,
        score INTEGER NOT NULL,
        severity TEXT NOT NULL,
        answers TEXT NOT NULL,
        clinician_notes TEXT,
        crisis_flag INTEGER NOT NULL DEFAULT 0,
        timestamp INTEGER NOT NULL,
        referral_made TEXT,
        follow_up_date TEXT
      )
    ''');

    // ── Outreach Events ───────────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE outreach_events (
        id TEXT PRIMARY KEY,
        event_type TEXT NOT NULL,
        location TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        people_reached INTEGER NOT NULL DEFAULT 0,
        referrals_made INTEGER NOT NULL DEFAULT 0,
        notes TEXT,
        date INTEGER NOT NULL
      )
    ''');

    // ── Safety Plans ──────────────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE safety_plans (
        id TEXT PRIMARY KEY,
        client_identifier TEXT NOT NULL,
        warning_signs TEXT,
        internal_coping TEXT,
        social_distractions TEXT,
        people_to_contact TEXT,
        professionals_to_call TEXT,
        means_restriction TEXT,
        clinician_name TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // ── Treatment Plans ───────────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE treatment_plans (
        id TEXT PRIMARY KEY,
        client_identifier TEXT NOT NULL,
        diagnosis_impression TEXT,
        goals TEXT,
        interventions TEXT,
        session_frequency TEXT,
        review_date TEXT,
        clinician_name TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // ── SOAP Session Notes ────────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE soap_notes (
        id TEXT PRIMARY KEY,
        client_identifier TEXT NOT NULL,
        subjective TEXT,
        objective TEXT,
        assessment TEXT,
        plan TEXT,
        session_context TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // ── Batch / Group Sessions ────────────────────────────────────────────────
    await db.execute('''
      CREATE TABLE group_sessions (
        id TEXT PRIMARY KEY,
        group_name TEXT NOT NULL,
        session_type TEXT NOT NULL,
        context TEXT NOT NULL,
        location TEXT,
        participants INTEGER NOT NULL DEFAULT 0,
        topics_covered TEXT,
        referrals_made INTEGER NOT NULL DEFAULT 0,
        notes TEXT,
        date INTEGER NOT NULL
      )
    ''');

    // ── Indexes ───────────────────────────────────────────────────────────────
    await db.execute('CREATE INDEX idx_sessions_client ON client_sessions(client_identifier)');
    await db.execute('CREATE INDEX idx_sessions_time ON client_sessions(timestamp DESC)');
    await db.execute('CREATE INDEX idx_sessions_crisis ON client_sessions(crisis_flag)');
    await db.execute('CREATE INDEX idx_outreach_date ON outreach_events(date DESC)');
    await db.execute('CREATE INDEX idx_safety_client ON safety_plans(client_identifier)');
    await db.execute('CREATE INDEX idx_soap_client ON soap_notes(client_identifier)');
  }

  // ── Client Sessions CRUD ──────────────────────────────────────────────────

  Future<int> insertSession(Map<String, dynamic> session) async {
    final db = await database;
    return db.insert('client_sessions', session, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSessionsByClient(String clientId) async {
    final db = await database;
    return db.query(
      'client_sessions',
      where: 'client_identifier = ?',
      whereArgs: [clientId],
      orderBy: 'timestamp DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getAllSessions({int? limit}) async {
    final db = await database;
    return db.query('client_sessions', orderBy: 'timestamp DESC', limit: limit);
  }

  Future<List<Map<String, dynamic>>> getTodaysSessions() async {
    final db = await database;
    final startOfDay = DateTime.now().copyWith(
      hour: 0, minute: 0, second: 0, millisecond: 0,
    ).millisecondsSinceEpoch;
    return db.query(
      'client_sessions',
      where: 'timestamp >= ?',
      whereArgs: [startOfDay],
      orderBy: 'timestamp DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getCrisisSessions({int limit = 10}) async {
    final db = await database;
    return db.query(
      'client_sessions',
      where: 'crisis_flag = 1',
      orderBy: 'timestamp DESC',
      limit: limit,
    );
  }

  /// Returns distinct clients with their most recent session details
  Future<List<Map<String, dynamic>>> getAllClients() async {
    final db = await database;
    return db.rawQuery('''
      SELECT 
        client_identifier,
        is_anonymous,
        MAX(timestamp) as last_seen,
        COUNT(*) as session_count,
        SUM(crisis_flag) as crisis_count,
        (SELECT assessment_type FROM client_sessions cs2 
         WHERE cs2.client_identifier = cs.client_identifier 
         ORDER BY timestamp DESC LIMIT 1) as last_assessment,
        (SELECT severity FROM client_sessions cs3 
         WHERE cs3.client_identifier = cs.client_identifier 
         ORDER BY timestamp DESC LIMIT 1) as last_severity,
        (SELECT score FROM client_sessions cs4 
         WHERE cs4.client_identifier = cs.client_identifier 
         ORDER BY timestamp DESC LIMIT 1) as last_score
      FROM client_sessions cs
      GROUP BY client_identifier
      ORDER BY last_seen DESC
    ''');
  }

  Future<int> updateSession(String id, Map<String, dynamic> data) async {
    final db = await database;
    return db.update('client_sessions', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSession(String id) async {
    final db = await database;
    return db.delete('client_sessions', where: 'id = ?', whereArgs: [id]);
  }

  // ── Outreach Events CRUD ──────────────────────────────────────────────────

  Future<int> insertOutreachEvent(Map<String, dynamic> event) async {
    final db = await database;
    return db.insert('outreach_events', event, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getOutreachEvents({int? limit}) async {
    final db = await database;
    return db.query('outreach_events', orderBy: 'date DESC', limit: limit);
  }

  Future<Map<String, dynamic>> getOutreachStats() async {
    final db = await database;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;
    final result = await db.rawQuery('''
      SELECT 
        COUNT(*) as total_events,
        SUM(people_reached) as total_reached,
        SUM(referrals_made) as total_referrals
      FROM outreach_events
      WHERE date >= $startOfMonth
    ''');
    return result.first;
  }

  // ── Safety Plans CRUD ─────────────────────────────────────────────────────

  Future<int> upsertSafetyPlan(Map<String, dynamic> plan) async {
    final db = await database;
    return db.insert('safety_plans', plan, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getSafetyPlan(String clientId) async {
    final db = await database;
    final result = await db.query(
      'safety_plans',
      where: 'client_identifier = ?',
      whereArgs: [clientId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ── SOAP Notes CRUD ───────────────────────────────────────────────────────

  Future<int> insertSoapNote(Map<String, dynamic> note) async {
    final db = await database;
    return db.insert('soap_notes', note, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSoapNotes(String clientId) async {
    final db = await database;
    return db.query(
      'soap_notes',
      where: 'client_identifier = ?',
      whereArgs: [clientId],
      orderBy: 'created_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getAllSoapNotes() async {
    final db = await database;
    return db.rawQuery('''
      SELECT client_identifier, MAX(updated_at) as last_updated, COUNT(*) as note_count
      FROM soap_notes
      GROUP BY client_identifier
      ORDER BY last_updated DESC
    ''');
  }

  // ── Group Sessions CRUD ───────────────────────────────────────────────────

  Future<int> insertGroupSession(Map<String, dynamic> session) async {
    final db = await database;
    return db.insert('group_sessions', session, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getGroupSessions() async {
    final db = await database;
    return db.query('group_sessions', orderBy: 'date DESC');
  }

  // ── Analytics Queries ─────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getDashboardStats() async {
    final db = await database;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final startOfWeek = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1))
        .millisecondsSinceEpoch;
    final startOfMonth = DateTime(now.year, now.month, 1).millisecondsSinceEpoch;

    final todayResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM client_sessions WHERE timestamp >= $startOfDay',
    );
    final weekResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM client_sessions WHERE timestamp >= $startOfWeek',
    );
    final monthResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM client_sessions WHERE timestamp >= $startOfMonth',
    );
    final crisisResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM client_sessions WHERE crisis_flag = 1 AND timestamp >= $startOfWeek',
    );
    final clientsResult = await db.rawQuery(
      'SELECT COUNT(DISTINCT client_identifier) as count FROM client_sessions',
    );

    return {
      'today': todayResult.first['count'],
      'this_week': weekResult.first['count'],
      'this_month': monthResult.first['count'],
      'crisis_flags': crisisResult.first['count'],
      'total_clients': clientsResult.first['count'],
    };
  }

  /// Severity distribution for analytics (last 90 days)
  Future<List<Map<String, dynamic>>> getSeverityDistribution() async {
    final db = await database;
    final since = DateTime.now().subtract(const Duration(days: 90)).millisecondsSinceEpoch;
    return db.rawQuery('''
      SELECT severity, assessment_type, COUNT(*) as count
      FROM client_sessions
      WHERE timestamp >= $since
      GROUP BY severity, assessment_type
      ORDER BY count DESC
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
