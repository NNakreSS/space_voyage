import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/RocketLaunch/model.dart';
import 'package:csv/csv.dart';
import 'package:space_voyage/widgets/time_line.dart';

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
        rocketCost: double.tryParse(csvTable[i][7].toString()),
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Timeline of space exploration",
            style: GoogleFonts.exo(
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: rocketLaunches.length,
                itemBuilder: (context, index) {
                  final rocketLaunch = rocketLaunches[index];
                  return MyTimeline(
                    timeBox: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            rocketLaunch.companyName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                        ),
                        // Body
                        Expanded(
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              customListTile(
                                title: "Location of the Launch",
                                subtitle: rocketLaunch.location,
                              ),
                              customListTile(
                                title: "Rocket Name",
                                subtitle: rocketLaunch.detail,
                              ),
                              customListTile(
                                title: "Rocket Status",
                                subtitle: rocketLaunch.rocketStatus
                                    .replaceAll("Status", ""),
                              ),
                              customListTile(
                                title: "Cost of the mission",
                                subtitle:
                                    "\$ ${rocketLaunch.rocketCost ?? "?"} million",
                              ),
                            ],
                          ),
                        ),
                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: rocketLaunch.missionStatus == "Success"
                                      ? Colors.green
                                      : Colors.red),
                              child: Text(
                                rocketLaunch.missionStatus,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              rocketLaunch.date,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 220, 220, 220),
                              ),
                            )
                          ],
                        ), // Adjust the space as needed
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );

  ListTile customListTile({required String title, required String subtitle}) =>
      ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 204, 204, 204),
          fontSize: 15,
        ),
      );
}
