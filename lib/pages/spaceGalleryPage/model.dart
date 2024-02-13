class NasaImage {
  String? copyright;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? title;
  String? url;

  NasaImage(
      {required this.copyright,
      required this.date,
      required this.explanation,
      required this.hdurl,
      required this.mediaType,
      required this.title,
      required this.url});

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
}
