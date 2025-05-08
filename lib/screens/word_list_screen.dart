import 'package:flutter/material.dart';
import 'package:vocablo_ai/widgets/appbar_widget.dart';

class WordListScreen extends StatelessWidget {
  const WordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: Center(
        child: Text("WordListScreen"),
      ),
    );
  }
}
