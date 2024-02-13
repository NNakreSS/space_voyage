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
      theme: ThemeData(useMaterial3: true),
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
        backgroundColor: Colors.transparent,
        //? tıklanan navigasyonun indexine göre vurrentPageIndex değerini günceller
        onDestinationSelected: (int index) =>
            setState(() => currentPageIndex = index),

        //? aktif seçili olanın arkaplan rengi
        indicatorColor: Colors.lightBlue,

        //? seçili olan navigasyon butonunu belirtmek için seçili olanun indexini veriyorum
        selectedIndex: currentPageIndex,

        //? buton labelını sadece seçiliyken göster
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

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
      body: _pageList[currentPageIndex],
    );
  }
}
