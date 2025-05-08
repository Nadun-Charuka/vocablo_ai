import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocablo_ai/providers/theme_provider.dart';
import 'package:vocablo_ai/widgets/appbar_widget.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = (themeMode == ThemeMode.dark);
    return Scaffold(
      appBar: AppbarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ProfileScreen"),
            IconButton(
              color: isDark ? Colors.yellow : Colors.blueGrey,
              icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            )
          ],
        ),
      ),
    );
  }
}
