class Planet {
  final String name;
  final String image;
  final Map<String, dynamic> info;

  Planet(this.name, this.image, this.info);

  static final planets = [
    Planet(
      "Neptune",
      "assets/images/neptune.png",
      {
        "Size": "49,244 km in diameter",
        "Distance from Sun": "Average 30.1 AU",
        "Orbital Period": "Approximately 165 years",
        "Gravity": "11.15 m/s²",
        "Info":
            "Neptune is the eighth and farthest known planet from the Sun in the Solar System."
      },
    ),
    Planet(
      "Uranus",
      "assets/images/uranus.png",
      {
        "Size": "50,724 km in diameter",
        "Distance from Sun": "Average 19.2 AU",
        "Orbital Period": "Approximately 84 years",
        "Gravity": "8.69 m/s²",
        "Info":
            "Uranus is the seventh planet from the Sun. It has the third-largest planetary radius and fourth-largest planetary mass in the Solar System."
      },
    ),
    Planet(
      "Saturn",
      "assets/images/saturn.png",
      {
        "Size": "116,460 km in diameter",
        "Distance from Sun": "Average 9.5 AU",
        "Orbital Period": "Approximately 29.5 years",
        "Gravity": "10.44 m/s²",
        "Info":
            "Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter."
      },
    ),
    Planet(
      "Jupiter",
      "assets/images/jupiter.png",
      {
        "Size": "139,820 km in diameter",
        "Distance from Sun": "Average 5.2 AU",
        "Orbital Period": "Approximately 12 years",
        "Gravity": "24.79 m/s²",
        "Info":
            "Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a gas giant with mass one-thousandth that of the Sun but is two and a half times the mass of all the other planets in the Solar System combined."
      },
    ),
    Planet(
      "Mars",
      "assets/images/mars.png",
      {
        "Size": "6,779 km in diameter",
        "Distance from Sun": "Average 1.52 AU",
        "Orbital Period": "Approximately 687 days",
        "Gravity": "3.7 m/s²",
        "Info":
            "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury."
      },
    ),
    Planet(
      "Earth",
      "assets/images/world.png",
      {
        "Size": "12,742 km in diameter",
        "Distance from Sun": "Average 1 AU",
        "Orbital Period": "365.24 days",
        "Gravity": "9.8 m/s²",
        "Info":
            "Earth is the third planet from the Sun and the only astronomical object known to harbor life."
      },
    ),
    Planet(
      "Venus",
      "assets/images/venus.png",
      {
        "Size": "12,104 km in diameter",
        "Distance from Sun": "Average 0.72 AU",
        "Orbital Period": "Approximately 225 days",
        "Gravity": "8.87 m/s²",
        "Info":
            "Venus is the second planet from the Sun. It is named after the Roman goddess of love and beauty."
      },
    ),
    Planet(
      "Mercury",
      "assets/images/mercury.png",
      {
        "Size": "4,880 km in diameter",
        "Distance from Sun": "Average 0.39 AU",
        "Orbital Period": "Approximately 88 days",
        "Gravity": "3.7 m/s²",
        "Info":
            "Mercury is the smallest and innermost planet in the Solar System. It is named after the Roman god of commerce, travel, and thievery."
      },
    ),
    Planet(
      "Sun",
      "assets/images/sun.png",
      {
        "Size": "1,391,000 km in diameter",
        "Distance from Sun": "At the center",
        "Gravity": "274 m/s² (on the surface)",
        "Info":
            "The Sun is the star at the center of the Solar System. It is by far the most important source of energy for life on Earth."
      },
    ),
  ];
}
