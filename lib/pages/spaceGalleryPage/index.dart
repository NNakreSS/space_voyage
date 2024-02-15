// from dart
import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
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
  late List<NasaImage> _images;
  bool _isLoading = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _images = [];
    _fetchImages();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchImages();
      }
    });
  }

  Future<void> _fetchImages() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    await dotenv.load(fileName: ".env");
    final String apiKey = dotenv.env['API_KEY'] ?? "DEMO_KEY";

    final Uri uri = Uri.parse(
        "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=10");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<NasaImage> newImages = jsonData
          .map((json) => NasaImage.fromJson(json))
          .where((data) => data.mediaType == "image")
          .toList();
      setState(() {
        _images.addAll(newImages);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed ${response.statusCode} : connect API ');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _images.isEmpty
            ? const SpinKitPulsingGrid(color: Colors.white)
            : Column(
                children: [
                  Expanded(
                    child: (MasonryGridView.builder(
                        controller: _scrollController,
                        itemCount: _images.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          NasaImage image = _images[index];
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: GestureDetector(
                                child: CachedNetworkImage(imageUrl: image.url),
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
                        })),
                  ),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SpinKitPulsingGrid(color: Colors.blue[300]!),
                    )
                ],
              ),
      );
}
