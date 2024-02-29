import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_voyage/pages/RocketLaunch/model.dart';
import 'package:csv/csv.dart';

class RocketLaunchPage extends StatefulWidget {
  const RocketLaunchPage({Key? key}) : super(key: key);

  @override
  State<RocketLaunchPage> createState() => _RocketLaunchPage();
}

class _RocketLaunchPage extends State<RocketLaunchPage> {
  @override
  Widget build(BuildContext context) => const RocketLaunchList();
}

class RocketLaunchList extends StatefulWidget {
  const RocketLaunchList({Key? key}) : super(key: key);

  @override
  State<RocketLaunchList> createState() => _RocketLaunchListState();
}

class _RocketLaunchListState extends State<RocketLaunchList> {
  late List<RocketLaunch> rocketLaunches;

  @override
  void initState() {
    rocketLaunches = [];
    loadRocketLaunches();
    super.initState();
  }

  Future<void> loadRocketLaunches() async {
    final csvString =
        await rootBundle.loadString('assets/data/space_corrected.csv');
    List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(csvString);
    List<RocketLaunch> launches = [];
    for (int i = 1; i < csvTable.length; i++) {
      launches.add(RocketLaunch(
        id: csvTable[i][1],
        companyName: csvTable[i][2],
        location: csvTable[i][3],
        date: csvTable[i][4],
        detail: csvTable[i][5],
        rocketStatus: csvTable[i][6],
        rocketCost: double.tryParse(csvTable[i][6].toString()) ?? 0.0,
        missionStatus: csvTable[i][8],
      ));
    }
    setState(() {
      if (mounted) {
        rocketLaunches = launches;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rocketLaunches.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(rocketLaunches[index].companyName),
          subtitle: Text(rocketLaunches[index].location),
          trailing: Text(rocketLaunches[index].date),
        );
      },
    );
  }
}
