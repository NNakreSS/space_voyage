import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/spaceGalleryPage/index.dart';
import 'package:space_voyage/widgets/elevated_button.dart';
import 'package:space_voyage/pages/SignPage/Sign_in.dart';
import 'package:space_voyage/pages/userProfile/index.dart';
import 'package:space_voyage/services/auth_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final User? user = AuthService().currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (_, snapshot) {
        return Scaffold(
          drawer: drawerWidget(context, snapshot),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                header(),
                main(context, snapshot),
              ],
            ),
          ),
        );
      });

  Drawer drawerWidget(BuildContext context, snapshot) {
    return Drawer(
      shape: const BorderDirectional(
          end: BorderSide(color: Colors.grey, width: 1)),
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Space Voyage",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white70, thickness: 1),
          userInfoDrawerButton(snapshot.hasData),
          favoriteDrawerButton(snapshot.hasData),
          const Divider(color: Colors.white70, thickness: 1),
          signButton(context, snapshot),
          const Divider(color: Colors.white70, thickness: 1),
          appInfoDrawerButton(),
        ],
      ),
    );
  }

  Widget appInfoDrawerButton() => CustomElevatedButton(
        backgroundColor: Colors.black,
        onPressed: () => (),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "App Info",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );

  Widget favoriteDrawerButton(hasData) {
    final bool disabled = hasData ? false : true;
    return CustomElevatedButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SpaceImages(
              isFavoriteImages: true,
            ),
          )),
      disabled: disabled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.favorite,
            color:
                disabled ? const Color.fromARGB(80, 244, 67, 30) : Colors.red,
            size: 30,
          ),
          const SizedBox(width: 10),
          const Text(
            "Favorites",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget userInfoDrawerButton(hasData) {
    final bool disabled = hasData ? false : true;
    return CustomElevatedButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfile(),
          )),
      disabled: disabled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.person_pin,
            color:
                disabled ? const Color.fromARGB(80, 33, 149, 243) : Colors.blue,
            size: 30,
          ),
          const SizedBox(width: 10),
          const Text(
            "Profile",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }

  Expanded main(BuildContext context, snapshot) {
    return Expanded(
      child: Stack(children: [
        earthImage(),
      ]),
    );
  }

  Widget signButton(BuildContext context, snapshot) =>
      !snapshot.hasData ? loginButton(context) : logoutButton(context);

  Widget loginButton(BuildContext context) => CustomElevatedButton(
        minimumSize: Size(MediaQuery.of(context).size.width, 0),
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            )),
        child: const Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      );

  Widget logoutButton(BuildContext context) => CustomElevatedButton(
        backgroundColor: Colors.red,
        minimumSize: Size(MediaQuery.of(context).size.width, 0),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text(
                      "Are you sure you want to logout?",
                      style: TextStyle(fontSize: 20),
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
                          AuthService().signOut();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ));
        },
        child: const Text(
          "Logout",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      );

  Transform earthImage() {
    return Transform.translate(
      offset: const Offset(-190, 0),
      child: Image.asset("assets/images/world.png")
          //? dünyanın dönmesini sağlayan animasyon
          .animate(onPlay: (controller) => controller.repeat(reverse: false))
          .rotate(duration: 50.seconds),
    );
  }

  Row header() {
    return Row(
      children: [
        welcommeText(),
        astronoutImage(),
      ],
    );
  }

  Expanded astronoutImage() {
    return Expanded(
      //? rotate ile astronout hafif yatay çevriliyor
      child: Transform.rotate(
              angle: 0.3, child: Image.asset("assets/images/astronout.png"))
          //? astronotun uzayda süzülme efektini vermesi için sonsuz döngüde aşağı yukarı animasyonu
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .slide(
            begin: const Offset(0, -.3),
            duration: 2.seconds,
          ),
    );
  }

  Expanded welcommeText() {
    return Expanded(
      child: Text(
        "Welcome To Space Voyage",
        softWrap: true,
        style: GoogleFonts.exo2(
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        //? ilk görünüm animasyonu , yazının ekranın solundan gelmesini sağlar
      ).animate().fade(duration: 500.ms).slide(
            begin: const Offset(-1, 0),
            duration: 500.ms,
          ),
    );
  }
}
