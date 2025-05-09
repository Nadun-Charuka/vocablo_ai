import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocablo_ai/features/translation/providers/translation_font_size_provider.dart';
import 'package:vocablo_ai/features/translation/providers/translation_provider.dart';
import 'package:vocablo_ai/shared/appbar_widget.dart';
import 'package:vocablo_ai/features/translation/widgets/did_you_mean_widget.dart';

class TranslationScreen extends ConsumerStatefulWidget {
  const TranslationScreen({super.key});

  @override
  ConsumerState<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends ConsumerState<TranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final Map<String, String> languages = {
    'English': 'en',
    'French': 'fr',
    'Sinhala': 'si',
    'Tamil': 'ta',
    'German': 'de',
    'Korean': 'ko',
    'Japanese': 'ja',
  };

  void _onTextChanged(String value) {
    if (value.trim().isEmpty) {
      ref
          .read(translatedTextProvider.notifier)
          .reset(); // 👈 clear state safely
      return;
    }

    ref.read(translatedTextProvider.notifier).translate(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);
    final translation = ref.watch(translatedTextProvider);
    final langState = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input TextField
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (value) {
                  _onTextChanged(value);
                  ref.read(fontSizeProvider.notifier).updateFontSize(value);
                },
                style: TextStyle(
                  fontSize: fontSize,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Text",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 26,
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Paste button
                      IconButton(
                        icon: const Icon(Icons.paste),
                        onPressed: () async {
                          final clipboardData =
                              await Clipboard.getData('text/plain');
                          final pastedText = clipboardData?.text ?? '';
                          if (pastedText.isNotEmpty) {
                            _controller.text = pastedText;
                            _controller.selection = TextSelection.fromPosition(
                              TextPosition(offset: pastedText.length),
                            );
                            _onTextChanged(pastedText);
                          }
                        },
                      ),
                      // Clear button (only if text is not empty)
                      if (_controller.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            _onTextChanged('');
                          },
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Did you mean suggestion
              DidYouMean(
                text: _controller.text,
                onSuggestionTap: (suggestion) {
                  _controller.text = suggestion;
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: suggestion.length),
                  );
                  _onTextChanged(suggestion);
                  _focusNode.requestFocus(); // bring back focus to input
                },
              ),

              const SizedBox(height: 16),

              // Language selectors and switch
              Row(
                children: [
                  // FROM LANGUAGE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal.shade200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
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
                        ),
                      ],
                    ),
                  ),

                  // SWITCH BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(
                      icon: const Icon(Icons.compare_arrows,
                          size: 32, color: Colors.teal),
                      onPressed: () {
                        final current = ref.read(languageProvider);
                        ref.read(languageProvider.notifier).state =
                            LanguageState(
                          sourceLang: current.targetLang,
                          targetLang: current.sourceLang,
                        );
                        _onTextChanged(_controller.text);
                      },
                    ),
                  ),

                  // TO LANGUAGE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal.shade200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Translated text display

              if (_controller.text.trim().isNotEmpty &&
                  translation.isNotEmpty) ...[
                const Text(
                  'Translation:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        translation,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: translation));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text("Copied to clipboard"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],

              if (translation.isNotEmpty &&
                  _controller.text.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text("Add to My List"),
                  onPressed: () {
                    ref
                        .read(translatedTextProvider.notifier)
                        .saveTranslation(_controller.text.trim());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 600),
                        content: Text("Added to your list"),
                      ),
                    );
                  },
                ),
              ],

              const SizedBox(height: 12),
              const Divider(
                thickness: 0.5,
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
