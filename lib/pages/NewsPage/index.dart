import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "News",
              style: GoogleFonts.exo(
                  textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              )),
            ),
            backgroundColor: Colors.black),
        body: Center(
          child: Text("News Page"),
        ),
      );
}
