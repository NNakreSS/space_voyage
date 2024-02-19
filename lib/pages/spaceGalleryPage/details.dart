import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class ImageDetails extends StatelessWidget {
  final NasaImage image;

  const ImageDetails({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Tooltip(
              message: image.title,
              child: Text(
                image.title!,
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
              Image.network(
                image.hdurl ?? image.url!,
                loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const Padding(
                            padding: EdgeInsets.all(60.0),
                            child: Center(
                              child: SpinKitCubeGrid(
                                color: Colors.white,
                              ),
                            ),
                          ),
              ),
              Positioned(
                right: 10.0,
                bottom: 70.0,
                child: GestureDetector(
                  onTap: () =>
                      downloadImage(image.hdurl ?? image.url, image.title!),
                  child: const Icon(
                    size: 40,
                    Icons.download,
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                right: 10.0,
                bottom: 20.0,
                child: Icon(
                  size: 40,
                  Icons.star_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        image.date!,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: image.copyright ?? "Nasa",
                        child: Text(
                          "©️ ${image.copyright ?? "Nasa"}",
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
                image.explanation!,
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
}

Future<void> downloadImage(String? url, String name) async {
  FileDownloader.downloadFile(
      url: url!,
      name: name,
      onDownloadCompleted: (path) {
        final File file = File(path);
        print(file);
      });
}
