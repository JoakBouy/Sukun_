import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

/// Provider to track network connectivity status
/// Notifies listeners when connection state changes
class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  bool _isOnline = true;
  bool _wasOffline = false;
  
  bool get isOnline => _isOnline;
  bool get wasOffline => _wasOffline;

  ConnectivityProvider() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking connectivity: $e');
      }
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final wasOnline = _isOnline;
    
    // Check if connection is available
    _isOnline = result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi ||
                result == ConnectivityResult.ethernet;
    
    // Track if we were offline and are now back online
    if (!wasOnline && _isOnline) {
      _wasOffline = true;
      if (kDebugMode) {
        print('Connection restored - triggering sync');
      }
    } else if (wasOnline && !_isOnline) {
      if (kDebugMode) {
        print('Connection lost - offline mode activated');
      }
    }
    
    notifyListeners();
  }

  /// Reset the wasOffline flag after sync is complete
  void resetOfflineFlag() {
    _wasOffline = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
