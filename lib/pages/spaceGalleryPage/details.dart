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
                image.title,
                style: const TextStyle(color: Colors.white),
              )),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            Image.network(
              image.hdurl ?? image.url,
              loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(
                            child: SpinKitCubeGrid(
                              color: Colors.white,
                            ),
                          ),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      image.date,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    Text(
                      "©️ ${image.copyright ?? "Nasa"}",
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
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
