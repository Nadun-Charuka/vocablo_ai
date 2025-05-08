import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Language model (optional but clean)
class LanguageState {
  final String sourceLang;
  final String targetLang;

  LanguageState({required this.sourceLang, required this.targetLang});

  LanguageState copyWith({String? sourceLang, String? targetLang}) {
    return LanguageState(
      sourceLang: sourceLang ?? this.sourceLang,
      targetLang: targetLang ?? this.targetLang,
    );
  }
}

// Default language state
final languageProvider = StateProvider<LanguageState>((ref) {
  return LanguageState(sourceLang: 'en', targetLang: 'si');
});

// Translation text
final translatedTextProvider =
    StateNotifierProvider<TranslationNotifier, String>((ref) {
  return TranslationNotifier(ref);
});

class TranslationNotifier extends StateNotifier<String> {
  final Ref ref;
  TranslationNotifier(this.ref) : super('');

  final String apiKey = 'AIzaSyCQqz0j2sVc71B6W0tTNE9aNVq5lajoYgU';

  Future<void> translate(String inputText) async {
    final lang = ref.read(languageProvider);

    if (inputText.trim().isEmpty) {
      state = '';
      return;
    }

    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2'),
      body: {
        'q': inputText,
        'source': lang.sourceLang,
        'target': lang.targetLang,
        'key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      state = data['data']['translations'][0]['translatedText'];
    } else {
      state = 'Error';
    }
  }
}
