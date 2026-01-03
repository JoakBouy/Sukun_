import 'dart:async';

/// Retry mechanism utility for network operations
class RetryMechanism {
  /// Execute a function with retry logic and exponential backoff
  static Future<T> execute<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
    bool Function(dynamic error)? shouldRetry,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (true) {
      try {
        return await operation();
      } catch (error) {
        attempt++;

        // Check if we should retry
        final canRetry = shouldRetry?.call(error) ?? true;
        
        if (attempt >= maxRetries || !canRetry) {
          rethrow;
        }

        // Wait before retrying with exponential backoff
        await Future.delayed(delay);
        delay = Duration(
          milliseconds: (delay.inMilliseconds * backoffMultiplier).round(),
        );
      }
    }
  }

  /// Execute with retry and return result or error
  static Future<RetryResult<T>> executeWithResult<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
    bool Function(dynamic error)? shouldRetry,
  }) async {
    try {
      final result = await execute(
        operation: operation,
        maxRetries: maxRetries,
        initialDelay: initialDelay,
        backoffMultiplier: backoffMultiplier,
        shouldRetry: shouldRetry,
      );
      return RetryResult.success(result);
    } catch (error) {
      return RetryResult.failure(error);
    }
  }
}

/// Result of a retry operation
class RetryResult<T> {
  final T? data;
  final dynamic error;
  final bool isSuccess;

  RetryResult.success(this.data)
      : error = null,
        isSuccess = true;

  RetryResult.failure(this.error)
      : data = null,
        isSuccess = false;
}
