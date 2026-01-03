import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Database helper for local data persistence
/// Manages SQLite database for offline support
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite is not supported on Web');
    }
    if (_database != null) return _database!;
    _database = await _initDB('sukun.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Journal Entries Table
    await db.execute('''
      CREATE TABLE journal_entries (
        id $idType,
        title $textType,
        content $textType,
        mood TEXT,
        created_at $intType,
        updated_at $intType,
        is_synced $boolType,
        word_count $intType
      )
    ''');

    // Mood Logs Table
    await db.execute('''
      CREATE TABLE mood_logs (
        id $idType,
        mood $textType,
        intensity $intType,
        note TEXT,
        created_at $intType,
        is_synced $boolType
      )
    ''');

    // Therapist Bookings Table
    await db.execute('''
      CREATE TABLE therapist_bookings (
        id $idType,
        therapist_id $textType,
        therapist_name $textType,
        date_time $intType,
        duration $intType,
        status $textType,
        notes TEXT,
        is_synced $boolType
      )
    ''');

    // User Preferences Table
    await db.execute('''
      CREATE TABLE user_preferences (
        key $idType,
        value $textType,
        updated_at $intType
      )
    ''');

    // Doctor Profiles Table
    await db.execute('''
      CREATE TABLE doctor_profiles (
        id $idType,
        user_id $textType,
        license_number TEXT,
        license_status $textType,
        specialization TEXT,
        years_of_experience INTEGER,
        bio TEXT,
        hourly_rate REAL,
        created_at $intType
      )
    ''');

    // Availability Slots Table
    await db.execute('''
      CREATE TABLE availability_slots (
        id $idType,
        doctor_id $textType,
        day_of_week $intType,
        start_time $textType,
        end_time $textType,
        is_available $boolType
      )
    ''');

    // Appointments Table
    await db.execute('''
      CREATE TABLE appointments (
        id $idType,
        patient_id $textType,
        doctor_id $textType,
        scheduled_time $intType,
        duration $intType,
        status $textType,
        session_type TEXT,
        notes TEXT,
        created_at $intType,
        is_synced $boolType
      )
    ''');

    // Session Notes Table
    await db.execute('''
      CREATE TABLE session_notes (
        id $idType,
        appointment_id $textType,
        doctor_id $textType,
        patient_id $textType,
        subjective TEXT,
        objective TEXT,
        assessment TEXT,
        plan TEXT,
        created_at $intType,
        is_synced $boolType
      )
    ''');

    // Create indexes for better query performance
    await db.execute(
        'CREATE INDEX idx_journal_created ON journal_entries(created_at DESC)');
    await db.execute(
        'CREATE INDEX idx_mood_created ON mood_logs(created_at DESC)');
    await db.execute(
        'CREATE INDEX idx_booking_date ON therapist_bookings(date_time)');
    await db.execute(
        'CREATE INDEX idx_doctor_user ON doctor_profiles(user_id)');
    await db.execute(
        'CREATE INDEX idx_availability_doctor ON availability_slots(doctor_id)');
    await db.execute(
        'CREATE INDEX idx_appointment_patient ON appointments(patient_id)');
    await db.execute(
        'CREATE INDEX idx_appointment_doctor ON appointments(doctor_id)');
    await db.execute(
        'CREATE INDEX idx_appointment_time ON appointments(scheduled_time)');
    await db.execute(
        'CREATE INDEX idx_session_appointment ON session_notes(appointment_id)');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    // Example:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE journal_entries ADD COLUMN tags TEXT');
    // }
  }

  // Journal Entry Operations
  Future<int> insertJournalEntry(Map<String, dynamic> entry) async {
    final db = await database;
    return await db.insert('journal_entries', entry,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getJournalEntries(
      {int? limit, int? offset}) async {
    final db = await database;
    return await db.query(
      'journal_entries',
      orderBy: 'created_at DESC',
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Map<String, dynamic>>> getUnsyncedJournalEntries() async {
    final db = await database;
    return await db.query(
      'journal_entries',
      where: 'is_synced = ?',
      whereArgs: [0],
    );
  }

  Future<int> updateJournalEntry(
      String id, Map<String, dynamic> entry) async {
    final db = await database;
    return await db.update(
      'journal_entries',
      entry,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteJournalEntry(String id) async {
    final db = await database;
    return await db.delete(
      'journal_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> markJournalEntrySynced(String id) async {
    final db = await database;
    return await db.update(
      'journal_entries',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Mood Log Operations
  Future<int> insertMoodLog(Map<String, dynamic> mood) async {
    final db = await database;
    return await db.insert('mood_logs', mood,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getMoodLogs(
      {int? limit, int? offset}) async {
    final db = await database;
    return await db.query(
      'mood_logs',
      orderBy: 'created_at DESC',
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Map<String, dynamic>>> getMoodLogsInRange(
      int startTime, int endTime) async {
    final db = await database;
    return await db.query(
      'mood_logs',
      where: 'created_at >= ? AND created_at <= ?',
      whereArgs: [startTime, endTime],
      orderBy: 'created_at ASC',
    );
  }

  // Therapist Booking Operations
  Future<int> insertBooking(Map<String, dynamic> booking) async {
    final db = await database;
    return await db.insert('therapist_bookings', booking,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getBookings() async {
    final db = await database;
    return await db.query(
      'therapist_bookings',
      orderBy: 'date_time ASC',
    );
  }

  // User Preferences Operations
  Future<int> setPreference(String key, String value) async {
    final db = await database;
    return await db.insert(
      'user_preferences',
      {
        'key': key,
        'value': value,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getPreference(String key) async {
    final db = await database;
    final result = await db.query(
      'user_preferences',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      return result.first['value'] as String?;
    }
    return null;
  }

  // Clear all data (for logout/reset)
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('journal_entries');
    await db.delete('mood_logs');
    await db.delete('therapist_bookings');
    await db.delete('user_preferences');
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
