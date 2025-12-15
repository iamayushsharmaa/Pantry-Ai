class ServerException implements Exception {}

class NetworkException implements Exception {}

class CacheException implements Exception {}

class ReAuthenticationRequiredException implements Exception {
  final String message;

  ReAuthenticationRequiredException([
    this.message =
        'This action requires recent authentication. Please log in again.',
  ]);

  @override
  String toString() => message;
}
