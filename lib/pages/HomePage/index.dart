import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: const [
            Icon(
              Icons.info,
              color: Colors.grey,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: const Text(
                  "Welcome To Space Voyage",
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ).animate().fade(duration: 500.ms).slide(
                      begin: const Offset(-1, 0),
                      duration: 500.ms,
                    ),
              ),
              Expanded(
                child: SizedBox(
                  child: Transform.rotate(
                      angle: 0.3,
                      child: Image.asset("assets/images/astronout.png")),
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .slide(
                      begin: const Offset(0, .2),
                      duration: 2.seconds,
                    ),
              ),
            ],
          ),
        ),
      );
}
