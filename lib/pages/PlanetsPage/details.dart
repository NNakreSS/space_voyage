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
            planet.name,
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
              planet.image,
              width: 250,
            ).animate().fade(duration: 2.seconds)),
            Expanded(
              child: ListView.builder(
                itemCount: planet.info.length,
                itemBuilder: (context, index) {
                  final entry = planet.info.entries.toList()[index];
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
            ),
          ],
        )),
      );
}
