import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget timeBox;
  const MyTimeline({
    Key? key,
    this.isFirst = false,
    this.isLast = false,
    required this.timeBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        // gap between
        height: MediaQuery.of(context).size.height * 0.6,
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          // line decor
          beforeLineStyle: const LineStyle(color: Colors.blueGrey),
          // icon decor
          indicatorStyle: IndicatorStyle(
            color: Colors.blue,
            width: 30,
            iconStyle: IconStyle(
              iconData: Icons.dashboard_outlined,
              color: Colors.white,
            ),
          ),
          endChild: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(82, 0, 59, 108),
            ),
            margin: const EdgeInsets.all(10),
            child: timeBox,
          ),
        ),
      );
}
