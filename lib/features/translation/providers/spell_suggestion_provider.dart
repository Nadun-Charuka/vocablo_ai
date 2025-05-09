import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final spellSuggestionProvider =
    FutureProvider.family<String?, String>((ref, text) async {
  if (text.trim().isEmpty) return null;

  final response = await http.post(
    Uri.parse('https://api.languagetool.org/v2/check'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'text': text,
      'language': 'en-US', // or dynamic if needed
    },
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final matches = result['matches'] as List;

    if (matches.isNotEmpty && matches[0]['replacements'] != null) {
      return matches[0]['replacements'][0]['value'];
    }
  }

  return null;
});
