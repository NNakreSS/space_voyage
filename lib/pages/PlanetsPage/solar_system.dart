import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class SolarSystem extends StatelessWidget {
  const SolarSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solar System'),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.blue[600]!, fontSize: 24.0),
      ),
      body: const Center(
        child: SizedBox(
          width: double.maxFinite, // maksimum genişlik
          height: double.maxFinite, // maksimum yükseklik
          //? modelviewer kütüphanesi ile güneş sistemi modellemesini görüntüler
          child: ModelViewer(
            backgroundColor: Colors.black,
            src: 'assets/models/solar_system.glb',
            iosSrc: "assets/models/solar_system.glb", //! ios için test etmedim
            alt: 'Solar System',
            autoPlay: true,
            autoRotate: true,
            cameraControls: true,
            ar: true, //? arttırılmış gerçeklik modunu aktif et
            loading: Loading.auto,
          ),
        ),
      ),
    );
  }
}
