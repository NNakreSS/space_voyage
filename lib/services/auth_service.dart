import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

// kullanıcı giriş
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

// kullanıcı kayıt
  Future<User?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _registerUser(
            name: name,
            email: email,
            password: password,
            uid: userCredential.user!.uid);
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Kullanıcı çıkışı
  Future<void> signOut() async {
    await _auth.signOut();
  }

// kullanıcı veritabanı oluştur
  Future<void> _registerUser(
      {required String name,
      required String email,
      required String password,
      required String uid}) async {
    await userCollection.doc(uid).set({
      "name": name,
      "email": email,
      "password": password,
      "admin": false,
    });
  }

  // Kullanıcının admin olup olmadığını kontrol eden metot
  Future<bool> isAdmin() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      DocumentSnapshot userDoc = await userCollection.doc(user.uid).get();
      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;
      return userData['admin'] ?? false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final List<String> secretInfos = ["password", "favorites", "admin"];
    try {
      User? user = _auth.currentUser;
      if (user == null) return {"error": "User Not Found"};

      DocumentSnapshot userDoc = await userCollection.doc(user.uid).get();
      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

      for (var infokey in secretInfos) {
        userData.remove(infokey);
      }

      return userData;
    } catch (e) {
      print(e.toString());
      return null; // Bir hata oluştuğunda null döndür
    }
  }
}
