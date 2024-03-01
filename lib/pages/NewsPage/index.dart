import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/NewsPage/add_news_form.dart';
import 'package:space_voyage/pages/NewsPage/model.dart';
import 'package:space_voyage/services/auth_service.dart';
import 'package:space_voyage/services/firestore_service.dart';

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
        floatingActionButton: FutureBuilder(
          future: AuthService().isAdmin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return snapshot.data!
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewsForm()),
                        );
                      },
                      foregroundColor: Colors.blue,
                      backgroundColor: const Color.fromARGB(198, 49, 49, 49),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  : const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
        body: Center(
            child: StreamBuilder(
                stream: FireStoreService().getNewsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitFadingCircle(color: Colors.white);
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error : ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    List<News> newsList = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        final thisNews = newsList[index];
                        print(thisNews);
                        return newsBox(thisNews);
                      },
                    );
                  }
                })),
      );

  Card newsBox(News thisNews) => Card(
        semanticContainer: true,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              newsIcon(thisNews),
              newsTitle(thisNews),
              newsDelete(thisNews)
            ],
          ),
        ),
      );

  FutureBuilder<bool> newsDelete(News thisNews) {
    return FutureBuilder(
      future: AuthService().isAdmin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return snapshot.data!
              ? deleteNewsButton(context, thisNews)
              : const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ListTile newsTitle(News thisNews) {
    return ListTile(
      title: Text(thisNews.title,
          style: GoogleFonts.exo(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )),
      subtitle: Text(
        thisNews.explanation,
        style: const TextStyle(color: Color.fromARGB(230, 255, 255, 255)),
      ),
    );
  }

  Row newsIcon(News thisNews) {
    return Row(
      children: [
        const Icon(
          Icons.newspaper_rounded,
          color: Colors.grey,
        ),
        const SizedBox(width: 20),
        Text(
          thisNews.date,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 162, 162, 162),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Row deleteNewsButton(BuildContext context, News thisNews) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
              title: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: const Text(
                "Are you sure you want to delete this news?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteNews(thisNews, context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          icon: const Icon(
            Icons.delete,
            color: Color.fromARGB(200, 244, 67, 54),
          ),
        ),
      ],
    );
  }

  void deleteNews(News thisNews, BuildContext context) {
    FireStoreService().deleteNewsToFirestore(thisNews.id).then(
          (data) => {
            if (data!["success"])
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 28, 28, 28),
                    content: Text(
                      "News deleted.",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color.fromARGB(255, 28, 28, 28),
                    content: Text(
                      data["error"],
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              }
          },
        );
  }
}
