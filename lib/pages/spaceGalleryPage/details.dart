import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class ImageDetails extends StatefulWidget {
  final NasaImage image;

  const ImageDetails({Key? key, required this.image}) : super(key: key);
  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  late String _downloadStatus;

  @override
  void initState() {
    super.initState();
    _downloadStatus = 'idle';
  }

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
              Image.network(
                widget.image.hdurl ?? widget.image.url!,
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
              const Positioned(
                right: 10.0,
                bottom: 20.0,
                child: Icon(
                  size: 40,
                  Icons.star_outline_rounded,
                  color: Colors.white,
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
}
