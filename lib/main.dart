import 'package:flutter/material.dart';
import 'package:space_voyage/pages/HomePage/index.dart';
import 'package:space_voyage/pages/PlanetsPage/index.dart';
import 'package:space_voyage/pages/spaceGalleryPage/index.dart';
import 'package:space_voyage/pages/TimeLinePage/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.black,
        hintColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      title: "Space Voyage",
      home: const AppHomeScreen(),
    );
  }
}

/* anasayfayı statefulwidget olarak tanımladığımız için,
değişen sayfa indexine göre body içerisindeki widget yani sayflarımız arasında geçiş sağlanacak*/
class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({Key? key}) : super(key: key);
  @override
  State<AppHomeScreen> createState() => _AppHomeScreen();
}

class _AppHomeScreen extends State<AppHomeScreen> {
  //? aktif olan sayfanın indexi;
  int currentPageIndex = 0;
  //? sayfalar arası geçiş yapabilmek için sayfaları bir list array olarak tutuyoruz.
  static const List<Widget> _pageList = [
    Home(),
    SpaceImages(),
    Planets(),
    TimeLine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //? en alt kısımda gözüken navigasyon barı
      bottomNavigationBar: NavigationBar(
        //? Sitil ayarları
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.lightBlue,
        backgroundColor: Colors.black,

        height: 60.0,

        //? tıklanan navigasyonun indexine göre currentPageIndex değerini günceller
        onDestinationSelected: (int index) =>
            setState(() => currentPageIndex = index),

        //? seçili olan navigasyon butonunu belirtmek için seçili olanun indexini veriyorum
        selectedIndex: currentPageIndex,

        // navigasyon tuşlarını içeren widget türünde liste
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white), label: ""),
          NavigationDestination(
              icon: Icon(Icons.image_outlined, color: Colors.white), label: ""),
          NavigationDestination(
              icon: Icon(Icons.south_america_outlined, color: Colors.white),
              label: ""),
          NavigationDestination(
              icon: Icon(Icons.timeline_outlined, color: Colors.white),
              label: ""),
        ],
      ),
      body: _pageList[currentPageIndex],
    );
  }
}
