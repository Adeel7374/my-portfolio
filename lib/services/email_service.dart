import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmailService {
  EmailService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // Provide the Firebase Function URL at build time:
  // flutter run -d chrome --dart-define=EMAIL_API_URL=https://<region>-<project>.cloudfunctions.net/sendEmail
  static String get _endpoint => const String.fromEnvironment('EMAIL_API_URL');
  // Zero-backend fallback (e.g., Formspree):
  // flutter run -d chrome --dart-define=FORMSPREE_URL=https://formspree.io/f/<id>
  static String get _formspreeUrl => const String.fromEnvironment('FORMSPREE_URL');

  Future<EmailResult> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    // Priority 1: Custom backend endpoint (expects JSON)
    if (_endpoint.isNotEmpty) {
      try {
        final response = await _client.post(
          Uri.parse(_endpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'email': email,
            'message': message,
          }),
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return const EmailResult(ok: true);
        }
        return EmailResult(
          ok: false,
          error: 'HTTP ${response.statusCode}: ${response.body}',
        );
      } catch (e) {
        return EmailResult(ok: false, error: e.toString());
      }
    }

    // Priority 2: Formspree (or similar) fallback (expects form data or JSON)
    if (_formspreeUrl.isNotEmpty) {
      try {
        final response = await _client.post(
          Uri.parse(_formspreeUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'email': email,
            'message': message,
          }),
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return const EmailResult(ok: true);
        }
        return EmailResult(
          ok: false,
          error: 'HTTP ${response.statusCode}: ${response.body}',
        );
      } catch (e) {
        return EmailResult(ok: false, error: e.toString());
      }
    }

    return const EmailResult(
      ok: false,
      error:
          'No email endpoint configured. Set EMAIL_API_URL or FORMSPREE_URL via --dart-define.',
    );
  }
}

@immutable
class EmailResult {
  final bool ok;
  final String? error;
  const EmailResult({required this.ok, this.error});
}


