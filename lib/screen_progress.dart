import 'package:flutter/material.dart';
import 'book.dart';


class ScreenProgress extends StatelessWidget {
  final Book book;
  final TextEditingController readCotroleer = TextEditingController();

  ScreenProgress({super.key, required this.book}) {
    readCotroleer.text = book.readProgress.toString();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Total page: ${book.totalPages}'),
            TextField(
              controller: readCotroleer,
              decoration: const InputDecoration(labelText: 'Total Read'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox( height: 25),
            ElevatedButton(
              child: const Text('...'),
              onPressed: () {
                if (readCotroleer.text.isNotEmpty) {
                  book.readProgress = int.parse(readCotroleer.text);
                  Navigator.pop(context, book);
                }
              },
            ),
          ],
        ),
        ),
    );
  }
}