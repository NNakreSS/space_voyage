import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/pages/SignPage/Sign_in.dart';
import 'package:space_voyage/services/auth_service.dart';

class Home extends StatelessWidget {
  final bool isLogin;
  final AuthService? authService;

  const Home({Key? key, required this.isLogin, this.authService})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
              main(context),
            ],
          ),
        ),
      );

  Expanded main(BuildContext context) {
    return Expanded(
      //? widgetların üst üste gelmesini sağlar (css absolute ile aynı işlev)
      child: Stack(children: [
        //? dünya görselini ekranın sol tarafına doğru yerleştiriyorum
        earthImage(),
        //? kullanıcı girişi yapıldıysa favoriler ve kullanıcı adını gösteren içerik ,! login butonu
        loginInfo(context)
      ]),
    );
  }

  Positioned loginInfo(BuildContext context) {
    return Positioned(
        right: 10,
        bottom: 70,
        child: !isLogin // eğer giriş yapılmadıysa
            ? loginButton(context)
            : userNameText());
  }

  Text userNameText() {
    return const Text(
      "Serkan Atmaca",
      style: TextStyle(color: Colors.black),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      // kullanıcı giriş ve hesap oluşturma butonu
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.white,
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          )),
      child: const Text(
        "Sign In",
        style: TextStyle(
            color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w900),
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
