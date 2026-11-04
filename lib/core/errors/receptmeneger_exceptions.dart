// lib/core/errors/receptmeneger_exceptions.dart

/// Base exception class for all ReceptMeneger-specific exceptions
class ReceptMenegerException implements Exception {
  final String message;

  const ReceptMenegerException(this.message);

  @override
  String toString() => 'ReceptMenegerException: $message';
}

/// Thrown when input validation fails
class ValidationException extends ReceptMenegerException {
  ValidationException(super.message);

  @override
  String toString() => 'ValidationException: $message';
}

/// Thrown when attempting to create a duplicate entry
class DuplicateException extends ReceptMenegerException {
  DuplicateException(super.message);

  @override
  String toString() => 'DuplicateException: $message';
}

/// Thrown when a requested resource is not found
class NotFoundException extends ReceptMenegerException {
  NotFoundException(super.message);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Thrown when a backup file was created by a newer app version than the
/// one attempting to restore it
class BackupVersionException extends ReceptMenegerException {
  const BackupVersionException(super.message);

  @override
  String toString() => 'BackupVersionException: $message';
}

// Rest of the file remains the same...
