import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flux_foot_admin/features/carousel_image/model/carousel_model.dart';

class FirebaseCarouselService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Single document for everything
  final String _collection = 'carousel_management';
  final String _docId = 'data';

  // ! Streams
  Stream<CarouselData?> getCarouselData() {
    return _db.collection(_collection).doc(_docId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return CarouselData.fromFirestore(snapshot.data()!);
      } else {
        return null;
      }
    });
  }

  // ! Save All Data (Slides + Settings)
  Future<void> saveCarouselData(CarouselData data) async {
    try {
      await _db.collection(_collection).doc(_docId).set(data.toFirestore());
      debugPrint('Carousel data saved successfully');
    } catch (e) {
      debugPrint('Error saving carousel data: $e');
      rethrow;
    }
  }
}
