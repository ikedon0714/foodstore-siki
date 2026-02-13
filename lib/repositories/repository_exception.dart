import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepositoryException implements Exception {
  RepositoryException(this.code, this.message, {this.original, this.stackTrace});

  final String code;
  final String message;
  final Object? original;
  final StackTrace? stackTrace;

  factory RepositoryException.fromFirebase(
      Object error, {
        StackTrace? stackTrace,
        String fallbackCode = 'unknown',
        String fallbackMessage = 'Unknown error occurred',
      }) {
    // FirebaseAuthException
    if (error is FirebaseAuthException) {
      return RepositoryException(
        error.code,
        error.message ?? fallbackMessage,
        original: error,
        stackTrace: stackTrace,
      );
    }

    // Firestore/FirebaseException
    if (error is FirebaseException) {
      return RepositoryException(
        error.code,
        error.message ?? fallbackMessage,
        original: error,
        stackTrace: stackTrace,
      );
    }

    // その他
    return RepositoryException(
      fallbackCode,
      error.toString(),
      original: error,
      stackTrace: stackTrace,
    );
  }

  @override
  String toString() => 'RepositoryException($code): $message';
}
