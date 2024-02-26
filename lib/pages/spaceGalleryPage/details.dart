import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';
import 'package:space_voyage/services/auth_service.dart';

class ImageDetails extends StatefulWidget {
  final NasaImage image;

  const ImageDetails({Key? key, required this.image}) : super(key: key);
  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  late String _downloadStatus = "idle";
  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Tooltip(
              message: widget.image.title,
              child: Text(
                widget.image.title!,
                style: const TextStyle(color: Colors.white),
              )),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            Stack(children: [
              SizedBox(
                width: double.maxFinite,
                height: 300,
                child: CachedNetworkImage(
                  imageUrl: widget.image.hdurl ?? widget.image.url!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const SpinKitCubeGrid(color: Colors.white),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 70.0,
                child: GestureDetector(
                  onTap: () => downloadImage(
                      widget.image.hdurl ?? widget.image.url,
                      widget.image.title!),
                  child: const Icon(
                    size: 40,
                    Icons.download,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 20.0,
                child: GestureDetector(
                  onTap: () => setFavoriteImage(widget.image),
                  child: Icon(
                    size: 40,
                    isFavorite(widget.image)
                        ? Icons.star_outlined
                        : Icons.star_outline_rounded,
                    color:
                        isFavorite(widget.image) ? Colors.yellow : Colors.white,
                  ),
                ),
              ),
              if (_downloadStatus == 'downloading')
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10))),
                    child: const Center(
                      child: Text(
                        "Downloading...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ).animate().slide(
                      begin: const Offset(-1, 0),
                      duration: const Duration(milliseconds: 500)),
                ),
              if (_downloadStatus == 'success' || _downloadStatus == 'error')
                Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: _downloadStatus == 'success'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(10, 10))),
                      child: Center(
                        child: Text(
                          _downloadStatus == 'success'
                              ? "Download Success"
                              : "Download Failed",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: const Duration(seconds: 1))
                        .fadeOut(
                          duration: const Duration(seconds: 4),
                        )),
            ]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.image.date!,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: widget.image.copyright ?? "Nasa",
                        child: Text(
                          "©️ ${widget.image.copyright ?? "Nasa"}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.image.explanation!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );

  // file downloader
  Future<void> downloadImage(String? url, String name) async {
    if (_downloadStatus != 'idle') return;
    setState(() {
      _downloadStatus = 'downloading';
    });
    try {
      FileDownloader.downloadFile(
          url: url!,
          name: name,
          onDownloadCompleted: (path) {
            setState(() => _downloadStatus = 'success');

            Future.delayed(
              const Duration(seconds: 4),
              () => setState(() => _downloadStatus = 'idle'),
            );
          });
    } catch (e) {
      setState(() => _downloadStatus = 'error');
      Future.delayed(
        const Duration(seconds: 4),
        () => setState(() => _downloadStatus = 'idle'),
      );
    }
  }

  void setFavoriteImage(NasaImage image) {
    if (isFavorite(image)) {
      removeFavoriteImage(image);
    } else {
      addFavorite(image);
    }
  }

  bool isFavorite(NasaImage image) {
    return true;
  }

  void removeFavoriteImage(NasaImage image) {}

  void addFavorite(NasaImage image) {}
}
