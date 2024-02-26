import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/SignPage/Sign_in.dart';
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
      builder: (context2, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.info,
                  color: Colors.blue[100]!,
                ),
              )
            ],
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

  Expanded main(BuildContext context, snapshot) {
    return Expanded(
      //? widgetların üst üste gelmesini sağlar (css absolute ile aynı işlev)
      child: Stack(children: [
        //? dünya görselini ekranın sol tarafına doğru yerleştiriyorum
        earthImage(),
        //? kullanıcı girişi yapıldıysa favoriler ve kullanıcı adını gösteren içerik ,! login butonu
        loginInfo(context, snapshot).animate().fade(duration: 500.microseconds)
      ]),
    );
  }

  Positioned loginInfo(BuildContext context, snapshot) {
    return Positioned(
      right: 10,
      bottom: 70,
      child: !snapshot.hasData
          // eğer giriş yapılmadıysa
          ? loginButton(context)
          // eğer giriş yapıldıysa
          : Column(
              children: [
                userNameText(),
                const SizedBox(height: 20),
                logOutButton(context)
              ],
            ),
    );
  }

  Widget userNameText() {
    return FutureBuilder<String?>(
      future: AuthService().getUserName(),
      builder: (context, snapshot) =>
          (snapshot.connectionState == ConnectionState.waiting)
              ? const SpinKitWave(
                  size: 20,
                  color: Colors.white,
                )
              : Text(
                  snapshot.data!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      // kullanıcı giriş ve hesap oluşturma butonu
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white10,
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          )),
      child: const Text(
        "Sign In",
        style: TextStyle(
            color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }

  logOutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white10,
      ),
      onPressed: () => AuthService().signOut(),
      child: Text(
        "Log Out",
        style: TextStyle(
            color: Colors.red[300]!, fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }

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
