import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocablo_ai/features/translation/providers/spell_suggestion_provider.dart';

class DidYouMean extends ConsumerWidget {
  final String text;
  final void Function(String suggestion) onSuggestionTap;

  const DidYouMean({
    super.key,
    required this.text,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionAsync = ref.watch(spellSuggestionProvider(text));

    return suggestionAsync.when(
      data: (suggestion) {
        if (suggestion != null &&
            suggestion.toLowerCase() != text.toLowerCase()) {
          return GestureDetector(
            onTap: () => onSuggestionTap(suggestion),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Did you mean ',
                      children: [
                        TextSpan(
                          text: suggestion,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '?'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () =>
          const SizedBox(height: 20, child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
