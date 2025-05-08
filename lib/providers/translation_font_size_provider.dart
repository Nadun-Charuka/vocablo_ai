import 'package:flutter_riverpod/flutter_riverpod.dart';

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(30.0);

  void updateFontSize(String text) {
    final wordCount = text.trim().split(RegExp(r'\s+')).length;
    if (wordCount < 2) {
      state = 32.0;
    } else if (wordCount < 10) {
      state = 28.0;
    } else if (wordCount < 20) {
      state = 26.0;
    } else if (wordCount < 30) {
      state = 24.0;
    } else {
      state = 18.0;
    }
  }
}
