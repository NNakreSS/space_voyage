// from dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// dependency packagets
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_voyage/pages/spaceGalleryPage/details.dart';
// models
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class SpaceImages extends StatefulWidget {
  const SpaceImages({Key? key}) : super(key: key);

  @override
  State<SpaceImages> createState() => _SpaceImages();
}

class _SpaceImages extends State<SpaceImages> {
  late Future<List<NasaImage>> _futureImages;

  @override
  void initState() {
    super.initState();
    _futureImages = fetchImages();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<NasaImage>>(
          future: _futureImages,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: SpinKitPulsingGrid(color: Colors.blue[300]!))
                : snapshot.hasError
                    ? Center(
                        child: Text(
                          "${snapshot.error}",
                          style:
                              TextStyle(fontSize: 20, color: Colors.red[300]!),
                        ),
                      )
                    : snapshot.hasData
                        ? MasonryGridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              NasaImage image = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: GestureDetector(
                                    child: Image.network(image.url),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageDetails(
                                          image: image,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text(
                              "Image not found",
                              style: TextStyle(fontSize: 24, color: Colors.red),
                            ),
                          );
          },
        ),
      );
}

Future<List<NasaImage>> fetchImages() async {
  await dotenv.load(fileName: ".env");
  final String apiKey = dotenv.env['API_KEY'] ?? "DEMO_KEY";

  final Uri uri =
      Uri.parse("https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=50");

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData
        .map((json) => NasaImage.fromJson(json))
        .where((data) => data.mediaType == "image")
        .toList();
  } else {
    throw Exception('Failed ${response.statusCode} : connect API ');
  }
}
