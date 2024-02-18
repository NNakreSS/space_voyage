import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/PlanetsPage/model.dart';

class PlanetCard extends StatelessWidget {
  const PlanetCard({
    super.key,
    required this.borderColor,
    required this.planet,
  });

  final Color borderColor;
  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: planet.planetName,
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(heightFactor: .5, child: Image.asset(planet.planetImage)),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                planet.planetName,
                style: GoogleFonts.exo2(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 46,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
