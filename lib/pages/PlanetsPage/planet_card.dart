import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/PlanetsPage/model.dart';

class PlanetCard extends StatelessWidget {
  const PlanetCard({
    super.key,
    required this.planet,
    required this.isFocused,
  });

  final Planet planet;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: planet.name,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(heightFactor: .5, child: Image.asset(planet.image)),
            if (isFocused)
              Text(
                planet.name,
                style: GoogleFonts.novaFlat(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
