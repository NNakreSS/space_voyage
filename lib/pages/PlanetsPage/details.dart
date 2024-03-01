import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:space_voyage/pages/PlanetsPage/model.dart';

class PlanetDetails extends StatefulWidget {
  final Planet planet;

  const PlanetDetails({Key? key, required this.planet}) : super(key: key);

  @override
  State<PlanetDetails> createState() => _PlanetDetailsState();
}

class _PlanetDetailsState extends State<PlanetDetails> {
  bool _isThreeDi = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.planet.name,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            threeDiButton(),
          ],
        ),
        body: Column(
          children: [
            planetView(),
            planetInfos(),
          ],
        ),
      );

  IconButton threeDiButton() {
    return IconButton(
      icon: const Icon(Icons.threed_rotation),
      onPressed: () {
        setState(() => _isThreeDi = !_isThreeDi);
      },
    );
  }

  Center planetView() {
    return Center(
      child: _isThreeDi
          ? modelView()
          : imageView().animate().fade(duration: 2.seconds),
    );
  }

  Expanded planetInfos() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.planet.info.length,
        itemBuilder: (context, index) {
          final entry = widget.planet.info.entries.toList()[index];
          return ListTile(
            iconColor: Colors.blue[300]!,
            leading: const Icon(Icons.radio_button_checked),
            title: Text(
              entry.key,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            subtitle: Text(
              entry.value.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Image imageView() {
    return Image.asset(
      widget.planet.image,
      width: 250,
      height: 250,
    );
  }

  SizedBox modelView() {
    return SizedBox(
      width: 250,
      height: 250,
      child: ModelViewer(
        backgroundColor: Colors.transparent,
        src: 'assets/models/${widget.planet.name}.glb',
        iosSrc: "assets/models/${widget.planet.name}.glb",
        alt: 'Solar System',
        autoPlay: true,
        autoRotate: true,
        cameraControls: true,
        ar: false, //? arttırılmış gerçeklik modunu disabled
      ),
    );
  }
}
