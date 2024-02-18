import 'package:flutter/material.dart';
import 'package:space_voyage/pages/PlanetsPage/model.dart';
import 'package:space_voyage/pages/PlanetsPage/perspective_view.dart';
import 'package:space_voyage/pages/PlanetsPage/planet_card.dart';
import 'package:space_voyage/pages/PlanetsPage/solar_system.dart';

class Planets extends StatefulWidget {
  const Planets({Key? key}) : super(key: key);

  @override
  State<Planets> createState() => _Planets();
}

class _Planets extends State<Planets> {
  late int _visibleItems = 3;
  late double _itemExtent = 270.0;
  late int _focusedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 16, 0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SolarSystem(),
                    )),
                child: Image.asset("assets/images/solar-system.png"),
              ),
            ),
          ],
        ),
        body: PerspectiveListView(
          visualizedItems: _visibleItems,
          itemExtent: _itemExtent,
          initialIndex: Planet.planets.length - 1,
          enableBackItemsShadow: true,
          backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(20),
          // tıklandığında detay sayfasına git
          onTapFrontItem: (index) {
            // final color = Colors.accents[index! % Colors.accents.length];
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<dynamic>(
            //     builder: (_) => ContactDetailScreen(
            //       contact: Contact.contacts[index],
            //       color: color,
            //     ),
            //   ),
            // );
          },
          onChangeFrontItem: (value) => setState(() {
            _focusedIndex = value;
          }),
          // listenin elemanları
          children: List.generate(
            Planet.planets.length,
            (index) {
              final planet = Planet.planets[index];
              return PlanetCard(
                planet: planet,
                isFocused: (index == _focusedIndex),
              );
            },
          ),
        ),
      );
}
