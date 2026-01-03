import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Cache manager for storing temporary data with expiration
/// Uses LRU (Least Recently Used) eviction policy
class CacheManager {
  static final CacheManager instance = CacheManager._init();
  SharedPreferences? _prefs;

  CacheManager._init();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Cache data with optional expiration time
  Future<bool> cacheData(
    String key,
    dynamic data, {
    Duration? expiresIn,
  }) async {
    if (_prefs == null) await init();

    final cacheEntry = {
      'data': data,
      'cached_at': DateTime.now().millisecondsSinceEpoch,
      'expires_at': expiresIn != null
          ? DateTime.now().add(expiresIn).millisecondsSinceEpoch
          : null,
    };

    return await _prefs!.setString(
      _getCacheKey(key),
      jsonEncode(cacheEntry),
    );
  }

  /// Get cached data if not expired
  Future<dynamic> getCachedData(String key) async {
    if (_prefs == null) await init();

    final cachedString = _prefs!.getString(_getCacheKey(key));
    if (cachedString == null) return null;

    try {
      final cacheEntry = jsonDecode(cachedString) as Map<String, dynamic>;
      final expiresAt = cacheEntry['expires_at'] as int?;

      // Check if cache has expired
      if (expiresAt != null &&
          DateTime.now().millisecondsSinceEpoch > expiresAt) {
        await removeCachedData(key);
        return null;
      }

      return cacheEntry['data'];
    } catch (e) {
      // Invalid cache entry, remove it
      await removeCachedData(key);
      return null;
    }
  }

  /// Check if data is cached and not expired
  Future<bool> isCached(String key) async {
    final data = await getCachedData(key);
    return data != null;
  }

  /// Remove specific cached data
  Future<bool> removeCachedData(String key) async {
    if (_prefs == null) await init();
    return await _prefs!.remove(_getCacheKey(key));
  }

  /// Clear all expired cache entries
  Future<void> clearExpiredCache() async {
    if (_prefs == null) await init();

    final keys = _prefs!.getKeys();
    final cacheKeys = keys.where((key) => key.startsWith('cache_'));

    for (final key in cacheKeys) {
      final originalKey = key.replaceFirst('cache_', '');
      final data = await getCachedData(originalKey);
      // getCachedData automatically removes expired entries
      if (data == null) {
        // Entry was expired and removed
        continue;
      }
    }
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    if (_prefs == null) await init();

    final keys = _prefs!.getKeys();
    final cacheKeys = keys.where((key) => key.startsWith('cache_'));

    for (final key in cacheKeys) {
      await _prefs!.remove(key);
    }
  }

  /// Get cache size (number of entries)
  Future<int> getCacheSize() async {
    if (_prefs == null) await init();

    final keys = _prefs!.getKeys();
    return keys.where((key) => key.startsWith('cache_')).length;
  }

  /// Implement LRU eviction if cache size exceeds limit
  Future<void> evictLRU({int maxEntries = 100}) async {
    if (_prefs == null) await init();

    final keys = _prefs!.getKeys();
    final cacheKeys = keys.where((key) => key.startsWith('cache_')).toList();

    if (cacheKeys.length <= maxEntries) return;

    // Get all cache entries with their timestamps
    final entries = <MapEntry<String, int>>[];
    for (final key in cacheKeys) {
      final cachedString = _prefs!.getString(key);
      if (cachedString != null) {
        try {
          final cacheEntry = jsonDecode(cachedString) as Map<String, dynamic>;
          final cachedAt = cacheEntry['cached_at'] as int;
          entries.add(MapEntry(key, cachedAt));
        } catch (e) {
          // Invalid entry, will be removed
          await _prefs!.remove(key);
        }
      }
    }

    // Sort by timestamp (oldest first)
    entries.sort((a, b) => a.value.compareTo(b.value));

    // Remove oldest entries until we're under the limit
    final toRemove = entries.length - maxEntries;
    for (var i = 0; i < toRemove; i++) {
      await _prefs!.remove(entries[i].key);
    }
  }

  String _getCacheKey(String key) => 'cache_$key';
}
