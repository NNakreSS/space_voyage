class Planet {
  final String planetName;
  final String planetImage;

  Planet(
    this.planetName,
    this.planetImage,
  );

  static final planets = [
    Planet("Neptün", "assets/images/neptune.png"),
    Planet("Uranüs", "assets/images/uranus.png"),
    Planet("Satürn", "assets/images/saturn.png"),
    Planet("Jüpiter", "assets/images/jupiter.png"),
    Planet("Mars", "assets/images/mars.png"),
    Planet("Dünya", "assets/images/world.png"),
    Planet("Venüs", "assets/images/venus.png"),
    Planet("Merkür", "assets/images/mercury.png"),
    Planet("Güneş", "assets/images/sun.png"),
  ];
}
