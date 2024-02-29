class RocketLaunch {
  final int id;
  final String companyName;
  final String location;
  final String date;
  final String detail;
  final String rocketStatus;
  final double? rocketCost;
  final String missionStatus;

  RocketLaunch({
    required this.id,
    required this.companyName,
    required this.location,
    required this.date,
    required this.detail,
    required this.rocketStatus,
    this.rocketCost,
    required this.missionStatus,
  });
}
