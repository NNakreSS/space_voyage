class News {
  String explanation;
  String title;
  String date;

  News({
    required this.explanation,
    required this.title,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      explanation: json["explanation"],
      title: json["title"],
      date: json["date"],
    );
  }

  // News nesnesini bir Map'e dönüştüren toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'explanation': explanation,
      'date': date,
    };
  }
}
