import 'package:flutter/material.dart';
import 'book.dart';
import 'add_book_screen.dart';
import 'screen_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];
  bool isArabic = false;

  String getProgressText(Book book) {
    double progress = (book.readProgress / book.totalPages) * 100;
    return isArabic
        ? 'الكاتب: ${book.author} - ${book.readProgress}/${book.totalPages} صفحة\n'
          '${progress.toStringAsFixed(1)}%'
        : 'Author: ${book.author} - ${book.readProgress}/${book.totalPages} pages\n'
          '${progress.toStringAsFixed(1)}%';
  }

  void updateBook(int index, Book updatedBook) {
    setState(() {
      books[index] = updatedBook;
    });
  }

  void language() {
    setState(() {
      isArabic = !isArabic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text(isArabic ? 'متتبع القراءة' : 'Reading Tracker'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: language,
            icon: const Icon(Icons.language, color: Colors.black),
            label: Text(isArabic ? 'English' : 'العربية',
                style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Colors.brown[400] ?? Colors.brown,
            Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: books.isEmpty
             ? Center(child: Text(isArabic ? 'لا توجد كتب مضافة' : 'No books added',
                  style: const TextStyle(fontSize: 20),
                ),
              )
            : ListView.separated(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(getProgressText(book)),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        Book? updatedBook = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenProgress(book: book),
                          ),
                        );
                        if (updatedBook != null) {
                          updateBook(index, updatedBook);
                        }
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[400],
        child: Icon(Icons.add, semanticLabel: isArabic ? 'إضافة' : 'Add'),
        onPressed: () async {
          Book? newBook = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBook()),
          );
          if (newBook != null) {
            setState(() {
              books.add(newBook);
            });
          }
        },
      ),
    );
  }
}
