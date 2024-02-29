import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/services/auth_service.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: GoogleFonts.exo(
              textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          )),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: userInfos(),
    );
  }

  FutureBuilder<Map<dynamic, dynamic>?> userInfos() => FutureBuilder<Map?>(
        future: AuthService().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitWave(
                size: 20,
                color: Colors.white,
              ),
            );
          } else {
            if (snapshot.hasData) {
              final Map? userInfo = snapshot.data;

              return ListView(
                children: userInfo!.entries.map((entry) {
                  return ListTile(
                    leading: const Icon(
                      Icons.circle_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      entry.key.toString().toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      entry.value.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(
                child: Text(
                  'Error retrieving user information',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          }
        },
      );
}
