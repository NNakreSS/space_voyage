import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class SpaceImages extends StatefulWidget {
  const SpaceImages({Key? key}) : super(key: key);

  @override
  State<SpaceImages> createState() => _SpaceImages();
}

class _SpaceImages extends State<SpaceImages> {
  late Future<List<NasaImage>> _futureImages;

  final Uri uri = Uri.parse(
      "https://api.nasa.gov/planetary/apod?api_key=MUk5nLBgDcRRJRJpbEdZ0dYjoGn48ObEYHq0XsfR&count=20");

  Future<List<NasaImage>> fetchImages() async {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((json) => NasaImage.fromJson(json))
          .where((data) => data.mediaType == "image")
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureImages = fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<NasaImage>>(
      future: _futureImages,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : snapshot.hasError
                ? Center(
                    child: Text(
                      "Error : ${snapshot.error}",
                      style: const TextStyle(fontSize: 24, color: Colors.red),
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
                                child: image.url != null
                                    ? Image.network(image.url!)
                                    : const Center(
                                        child: Text("Image URL not found"))),
                          );
                        })
                    : const Center(
                        child: Text(
                          "Image not found",
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      );
      },
    ));
  }
}
