import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocablo_ai/providers/translation_font_size_provider.dart';
import 'package:vocablo_ai/widgets/appbar_widget.dart';

class AddNewScreen extends ConsumerWidget {
  const AddNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: TextField(
                  onChanged: (value) {
                    ref.read(fontSizeProvider.notifier).updateFontSize(value);
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter Text...",
                    hintStyle: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
