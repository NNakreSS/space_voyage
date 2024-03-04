import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_voyage/pages/NewsPage/model.dart';
import 'package:space_voyage/pages/spaceGalleryPage/model.dart';

class FireStoreService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');

  // Kullanıcının belirli bir görselin favorilere eklemesi
  Future<void> addFavorite(String userId, NasaImage imageData) async {
    try {
      await userCollection.doc(userId).set({
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
      final DocumentSnapshot snapshot = await userCollection.doc(userId).get();
      if (snapshot.exists) {
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['favorites'] != null) {
          final List<dynamic> favoriteDataList = data['favorites'];
          final List<NasaImage> favorites = favoriteDataList.reversed
              .map((data) => NasaImage.fromJson(data))
              .toList();
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
      await userCollection.doc(userId).update({
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
      final DocumentSnapshot snapshot = await userCollection.doc(userId).get();
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

  Future<Map?> addNewsToFirestore(Map newsItem) async {
    try {
      await newsCollection.add({
        'title': newsItem["title"],
        'explanation': newsItem["explanation"],
        'date': newsItem["date"],
        "timestamp": Timestamp.fromDate(DateTime.now()),
      });
      return {"success": true}; // Başarı durumunda true döndür
    } catch (e) {
      return {"success": false, "error": e}; // Hata durumunda false döndür
    }
  }

  Future<Map?> deleteNewsToFirestore(String id) async {
    try {
      await newsCollection.doc(id).delete();
      return {"success": true}; // Başarı durumunda true döndür
    } catch (e) {
      return {"success": false, "error": e}; // Hata durumunda false döndür
    }
  }

  Future<List<News>> getNewsToFirestore(News newsItem) async {
    final newsSnapshot = await newsCollection.get();
    List<News> newsList = [];
    for (var doc in newsSnapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      newsList.add(News.fromJson(doc.id, data!));
    }
    return newsList;
  }

  Stream<List<News>> getNewsStream() {
    return newsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return News.fromJson(doc.id, data);
      }).toList();
    });
  }
}
