class News {
  String explanation;
  String title;
  String date;
  String id;

  News({
    required this.explanation,
    required this.title,
    required this.date,
    required this.id,
  });

  factory News.fromJson(String id, Map<String, dynamic> json) {
    return News(
      id: id,
      explanation: json["explanation"],
      title: json["title"],
      date: json["date"],
    );
  }

  // News nesnesini bir Map'e dönüştüren toJson metodu
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'explanation': explanation,
      'date': date,
    };
  }
}
