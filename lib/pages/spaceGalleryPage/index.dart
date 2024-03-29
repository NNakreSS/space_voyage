// from dart
import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// dependency packagets
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_voyage/pages/spaceGalleryPage/details.dart';
// models
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';
import 'package:space_voyage/services/auth_service.dart';
import 'package:space_voyage/services/firestore_service.dart';

class SpaceImages extends StatefulWidget {
  final bool? isFavoriteImages;

  const SpaceImages({Key? key, this.isFavoriteImages}) : super(key: key);

  @override
  State<SpaceImages> createState() => _SpaceImages();
}

class _SpaceImages extends State<SpaceImages> {
  final User? user = AuthService().currentUser;
  late List<NasaImage> _images;
  bool _isLoading = false;
  String _errorMessage = "";

  bool _useBackUp = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _images = [];
    _fetchImages();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          widget.isFavoriteImages == null) {
        _fetchImages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback func) {
    if (mounted) {
      super.setState(func);
    }
  }

  Future<void> _fetchImages() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (widget.isFavoriteImages == null) {
      await dotenv.load(fileName: ".env");
      final String apiKey = dotenv.env['API_KEY'] ?? "DEMO_KEY";

      final Uri uri = Uri.parse(
          "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=15");

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
          _errorMessage = "";
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage =
              "Connection to NASA APIs could not be established ${response.statusCode}";
        });

        _fetchBackupDataImages();
      }
    } else {
      final List<NasaImage> favoriteImages =
          await FireStoreService().getUserFavorites(user!.uid);
      setState(() {
        _images.addAll(favoriteImages);
        _isLoading = false;
        _errorMessage = "";
      });
    }
  }

  Future<void> _fetchBackupDataImages() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/backup_data.json');
      final data = await json.decode(response);
      final List<NasaImage> newImages = data
          .map((json) => NasaImage.fromJson(json))
          .where((data) => data.mediaType == "image")
          .whereType<NasaImage>()
          .toList();

      setState(() {
        _useBackUp = true;
        _images.addAll(newImages);
        _isLoading = false;
        _errorMessage = "";
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "load backup error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: widget.isFavoriteImages != null
            ? AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "Favorites",
                  style: GoogleFonts.exo(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  )),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              )
            : null,
        body: _errorMessage != ""
            ? errorMessage()
            : _images.isEmpty
                ? const SpinKitPulsingGrid(color: Colors.white)
                : main(),
      );

  Column main() {
    return Column(
      children: [
        Expanded(
          child: images(),
        ),
        if (_isLoading && !_useBackUp && widget.isFavoriteImages == null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SpinKitDualRing(color: Colors.blue[100]!),
          )
      ],
    );
  }

  Padding images() {
    return Padding(
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
                    imageUrl: image.url!,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        const SpinKitFadingGrid(color: Colors.grey),
                    errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        )),
              ),
            );
          },
        ),
      ),
    );
  }

  Center errorMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          Center(
            child: Text(
              _errorMessage,
              softWrap: true,
              style: const TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
