class Book {
  String title;
  String author;
  int totalPages;
  int readProgress;
  String coverImage;

  Book({
    required this.title,
    required this.author,
    required this.totalPages,
    required this.coverImage,
    this.readProgress = 0,
  });

  double get progressPercentage {
    if (totalPages == 0) return 0.0;
    return (readProgress / totalPages) * 100;
  }
}
