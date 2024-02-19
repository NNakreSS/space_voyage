import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:space_voyage/pages/PlanetsPage/model.dart';

class PlanetDetails extends StatelessWidget {
  final Planet planet;

  const PlanetDetails({Key? key, required this.planet}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            planet.planetName,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.threed_rotation),
            ),
          ],
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Expanded(
            child: Column(
          children: [
            Center(
                child: Image.asset(
              planet.planetImage,
              width: 330,
            ).animate().fade(duration: 2.seconds)),
          ],
        )),
      );
}
