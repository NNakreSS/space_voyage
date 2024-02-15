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
        "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=20");

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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.custom(
                        controller: _scrollController,
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: const [
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: _images.length,
                          (context, index) {
                            final image = _images[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDetails(
                                      image: image,
                                    ),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: image.url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      SpinKitCubeGrid(
                                    color: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
