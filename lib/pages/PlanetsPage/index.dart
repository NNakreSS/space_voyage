import 'package:flutter/material.dart';
import 'package:space_voyage/pages/PlanetsPage/solar_system.dart';

class Planets extends StatefulWidget {
  const Planets({Key? key}) : super(key: key);

  @override
  State<Planets> createState() => _Planets();
}

class _Planets extends State<Planets> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: SolarSystem());
}
