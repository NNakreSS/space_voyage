import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLine();
}

class _TimeLine extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      child: const Text(
        "Time Lines",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 28,
        ),
      ),
    );
  }
}
