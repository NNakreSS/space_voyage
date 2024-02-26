class NasaImage {
  String? copyright;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? title;
  String? url;

  NasaImage(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.mediaType,
      this.title,
      this.url});

  factory NasaImage.fromJson(Map<String, dynamic> json) {
    return NasaImage(
      copyright: json["copyright"],
      date: json["date"],
      explanation: json["explanation"],
      hdurl: json["hdurl"],
      mediaType: json["media_type"],
      title: json["title"],
      url: json["url"],
    );
  }

  // NasaImage nesnesini bir Map'e dönüştüren toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'hdurl': hdurl,
      'url': url,
      'date': date,
      'explanation': explanation,
      // Diğer özellikler...
    };
  }
}
