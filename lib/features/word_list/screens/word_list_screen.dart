import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocablo_ai/shared/appbar_widget.dart';

class WordListScreen extends StatelessWidget {
  const WordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Map>('translations');

    return Scaffold(
      appBar: AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('No translations yet.'));
            }

            final items = box.toMap().entries.toList()
              ..sort((a, b) => (b.value['timestamp'] as int)
                  .compareTo(a.value['timestamp'] as int));

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final entry = items[index];
                final key = entry.key;
                final value = entry.value;
                final word = value['word'] ?? '';
                final translated = value['translated'] ?? '';

                return Dismissible(
                  key: ValueKey(key),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    color: Colors.redAccent.shade100,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    final deletedItem = value;
                    final deletedKey = key;

                    box.delete(deletedKey);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Translation deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            box.put(deletedKey, deletedItem);
                          },
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text.rich(
                        TextSpan(
                          text: "$word - ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          children: [
                            TextSpan(
                                text: "$translated",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                          ],
                        ),
                      ),
                      titleTextStyle: TextStyle(
                        fontSize: 18,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: translated));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Copied to clipboard')),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
