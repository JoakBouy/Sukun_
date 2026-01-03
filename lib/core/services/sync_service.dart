import 'package:flutter/foundation.dart';
import 'package:freud_ai/core/data/local/database_helper.dart';

/// Service to sync local data with remote server
/// Handles background sync when connection is restored
class SyncService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  /// Sync all unsynced data to server
  Future<void> syncAll() async {
    if (kIsWeb) return; // Skip sync on web

    if (_isSyncing) {
      if (kDebugMode) {
        print('Sync already in progress, skipping');
      }
      return;
    }

    _isSyncing = true;
    
    try {
      await _syncJournalEntries();
      await _syncMoodLogs();
      await _syncBookings();
      
      if (kDebugMode) {
        print('Sync completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sync error: $e');
      }
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync journal entries
  Future<void> _syncJournalEntries() async {
    final unsyncedEntries = await _dbHelper.getUnsyncedJournalEntries();
    
    if (unsyncedEntries.isEmpty) {
      if (kDebugMode) {
        print('No unsynced journal entries');
      }
      return;
    }

    if (kDebugMode) {
      print('Syncing ${unsyncedEntries.length} journal entries');
    }

    for (final entry in unsyncedEntries) {
      try {
        // TODO: Replace with actual API call
        await _mockApiCall(entry);
        
        // Mark as synced in local database
        await _dbHelper.markJournalEntrySynced(entry['id'] as String);
        
        if (kDebugMode) {
          print('Synced journal entry: ${entry['id']}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to sync journal entry ${entry['id']}: $e');
        }
        // Continue with other entries even if one fails
      }
    }
  }

  /// Sync mood logs
  Future<void> _syncMoodLogs() async {
    // TODO: Implement mood log sync similar to journal entries
    if (kDebugMode) {
      print('Mood log sync not yet implemented');
    }
  }

  /// Sync bookings
  Future<void> _syncBookings() async {
    // TODO: Implement booking sync similar to journal entries
    if (kDebugMode) {
      print('Booking sync not yet implemented');
    }
  }

  /// Mock API call - replace with actual API implementation
  Future<void> _mockApiCall(Map<String, dynamic> data) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In production, this would be:
    // final response = await http.post(
    //   Uri.parse('https://api.sukun.app/journal/sync'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(data),
    // );
    // if (response.statusCode != 200) throw Exception('Sync failed');
  }

  /// Handle conflict resolution
  /// Called when server has newer data than local
  Future<void> resolveConflict(
    String id,
    Map<String, dynamic> localData,
    Map<String, dynamic> serverData,
  ) async {
    // Simple strategy: server wins
    // In production, you might want to:
    // 1. Show user a dialog to choose which version to keep
    // 2. Merge the data intelligently
    // 3. Keep both versions with conflict markers
    
    final localUpdated = localData['updated_at'] as int;
    final serverUpdated = serverData['updated_at'] as int;
    
    if (serverUpdated > localUpdated) {
      // Server data is newer, update local
      await _dbHelper.updateJournalEntry(id, serverData);
      if (kDebugMode) {
        print('Conflict resolved: server data used for $id');
      }
    } else {
      // Local data is newer, sync to server
      await _mockApiCall(localData);
      if (kDebugMode) {
        print('Conflict resolved: local data synced for $id');
      }
    }
  }
}
