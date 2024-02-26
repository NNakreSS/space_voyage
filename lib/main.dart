import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:space_voyage/pages/HomePage/index.dart';
import 'package:space_voyage/pages/PlanetsPage/index.dart';
import 'package:space_voyage/pages/spaceGalleryPage/index.dart';
import 'package:space_voyage/pages/TimeLinePage/index.dart';
// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:space_voyage/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.white,
        hintColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      title: "Space Voyage",
      home: StreamBuilder(
        stream: _authService.user,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          return const AppHomeScreen();
        },
      ),
    );
  }
}

/* Ana sayfayı statefulwidget olarak tanımladığımız için,
değişen sayfa indexine göre body içerisindeki widget yani sayflarımız arasında geçiş sağlanacak*/
class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreen();
}

class _AppHomeScreen extends State<AppHomeScreen> {
  // Aktif olan sayfanın indexi
  int currentPageIndex = 0;
  // Sayfalar arası geçiş yapabilmek için sayfaları bir list array olarak tutuyoruz.
  List<Widget> _pageList = [];

  @override
  void initState() {
    super.initState();
    _pageList = [
      const Home(),
      const SpaceImages(),
      const Planets(),
      const TimeLine(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // En alt kısımda gözüken navigasyon barı
      bottomNavigationBar: NavigationBar(
        // Sitil ayarları
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.lightBlue,
        backgroundColor: Colors.black,
        height: 60.0,

        // Tıklanan navigasyonun indexine göre currentPageIndex değerini günceller
        onDestinationSelected: (int index) =>
            setState(() => currentPageIndex = index),

        // Seçili olan navigasyon butonunu belirtmek için seçili olanın indexini veriyorum
        selectedIndex: currentPageIndex,

        // Navigasyon tuşlarını içeren widget türünde liste
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.image_outlined, color: Colors.white),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.south_america_outlined, color: Colors.white),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.timeline_outlined, color: Colors.white),
            label: "",
          ),
        ],
      ),
      body: _pageList[currentPageIndex],
    );
  }
}
