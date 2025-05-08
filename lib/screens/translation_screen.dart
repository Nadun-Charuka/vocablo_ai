import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocablo_ai/providers/translation_provider.dart';

class TranslationScreen extends ConsumerStatefulWidget {
  const TranslationScreen({super.key});

  @override
  ConsumerState<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends ConsumerState<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();

  // Simple language map (you can add more)
  final Map<String, String> languages = {
    'English': 'en',
    'French': 'fr',
    'Sinhala': 'si',
    'Tamil': 'ta',
    'Hindi': 'hi',
    'German': 'de',
    'Spanish': 'es',
  };

  void _onTextChanged(String value) {
    ref.read(translatedTextProvider.notifier).translate(value);
  }

  @override
  Widget build(BuildContext context) {
    final translation = ref.watch(translatedTextProvider);
    final langState = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Translator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              decoration: const InputDecoration(
                hintText: "Type a word...",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: langState.sourceLang,
                  items: languages.entries
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.key),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    final current = ref.read(languageProvider);
                    ref.read(languageProvider.notifier).state =
                        current.copyWith(sourceLang: newValue);
                    _onTextChanged(_controller.text);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.compare_arrows,
                      size: 32, color: Colors.teal),
                  onPressed: () {
                    final current = ref.read(languageProvider);
                    ref.read(languageProvider.notifier).state = LanguageState(
                      sourceLang: current.targetLang,
                      targetLang: current.sourceLang,
                    );
                    _onTextChanged(_controller.text); // trigger re-translation
                  },
                ),
                DropdownButton<String>(
                  value: langState.targetLang,
                  items: languages.entries
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.key),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    final current = ref.read(languageProvider);
                    ref.read(languageProvider.notifier).state =
                        current.copyWith(targetLang: newValue);
                    _onTextChanged(_controller.text);
                  },
                ),
              ],
            ),

            // Input box

            const SizedBox(height: 20),

            // Translated text
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                label: Text(
                  translation,
                  style: const TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
