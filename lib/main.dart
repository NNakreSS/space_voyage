import 'package:flutter/material.dart';
import 'package:space_voyage/pages/space_images.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: "Space Voyage",
      home: const HomePage(),
    );
  }
}

/* anasayfayı statefulwidget olarak tanımladığımız için,
değişen sayfa indexine göre body içerisindeki widget yani sayflarımız arasında geçiş sağlanacak*/
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //? aktif olan sayfanın indexi;
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      //? en alt kısımda gözüken navigasyon barı
      bottomNavigationBar: NavigationBar(
        //? tıklanan navigasyonun indexine göre vurrentPageIndex değerini günceller
        onDestinationSelected: (int index) =>
            setState(() => currentPageIndex = index),

        //? aktif seçili olanın arkaplan rengi
        indicatorColor: Colors.amber,

        //? seçili olan navigasyon butonunu belirtmek için seçili olanun indexini veriyorum
        selectedIndex: currentPageIndex,

        // navigasyon tuşlarını içeren widget türünde liste
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.image), label: "Images"),
          NavigationDestination(
              icon: Icon(Icons.stop_circle_outlined), label: "Planets"),
          NavigationDestination(
              icon: Icon(Icons.timeline_outlined), label: "Time Line"),
        ],
      ),
      body: pageList[currentPageIndex],
    );
  }
}

//? sayfalar arası geçiş yapabilmek için sayfaları bir list array olarak tutuyoruz.
List pageList = const [SpaceImages()];
