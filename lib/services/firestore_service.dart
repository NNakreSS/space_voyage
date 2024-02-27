import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class FireStoreService {
  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection("users");

  // Kullanıcının belirli bir görselin favorilere eklemesi
  Future<void> addFavorite(String userId, NasaImage imageData) async {
    try {
      await favoritesCollection.doc(userId).set({
        'favorites': FieldValue.arrayUnion([imageData.toJson()]),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error adding favorite: $e");
      throw e;
    }
  }

  // Kullanıcının favori görsellerini getirme
  Future<List<NasaImage>> getFavorites(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await favoritesCollection.doc(userId).get();
      if (snapshot.exists) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['favorites'] != null) {
          final List<dynamic> favoriteDataList = data['favorites'];
          final List<NasaImage> favorites =
              favoriteDataList.map((data) => NasaImage.fromJson(data)).toList();
          return favorites;
        }
      }
      return [];
    } catch (e) {
      print("Error getting favorites: $e");
      throw e;
    }
  }

  // Kullanıcının belirli bir görseli favorilerden çıkarması
  Future<void> removeFavorite(String userId, NasaImage imageData) async {
    try {
      await favoritesCollection.doc(userId).update({
        'favorites': FieldValue.arrayRemove([imageData.toJson()]),
      });
    } catch (e) {
      print("Error removing favorite: $e");
      throw e;
    }
  }

  // Kullanıcının favori görsellerini getirme
  Future<List<NasaImage>> getUserFavorites(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await favoritesCollection.doc(userId).get();
      if (snapshot.exists) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['favorites'] != null) {
          final List<dynamic> favoriteDataList = data['favorites'];
          final List<NasaImage> favorites =
              favoriteDataList.map((data) => NasaImage.fromJson(data)).toList();
          return favorites;
        }
      }
      return [];
    } catch (e) {
      print("Error getting user favorites: $e");
      throw e;
    }
  }
}
