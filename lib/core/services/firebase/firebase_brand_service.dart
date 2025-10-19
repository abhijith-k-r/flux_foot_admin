// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';

class FirebaseBrandService {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    // ! Adding a Brand
    Future<void> addBrand(BrandModel brand)async{
      try {
      await _db.collection('brands').add(brand.toFireStore());
      debugPrint('Category added successfully to Firestore!');
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
    }


     // ! Streaming Brands (Read)
  Stream<List<BrandModel>> readBrands() {
    return _db.collection('brands').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => BrandModel.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // ! Updating a Brands
  Future<void> updateBrand(BrandModel brand) async {
    try {
      if (brand.id.isEmpty) {
        throw Exception('brand ID is required for updating');
      }

      _db
          .collection('brands')
          .doc(brand.id)
          .update(brand.toFireStore());
      debugPrint('brand updated successfully: ${brand.name}');
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  // ! Update Category Status (Block / Activ)
  Future<void> updateBrandStatus(
    BuildContext context,
    BrandModel category,
    String newStatus,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('brands').doc(category.id).update({
        'status': newStatus.toLowerCase(),
      });

      String finalStatus = newStatus == 'Block' ? 'blocked' : 'active';

      await firestore.collection('brands').doc(category.id).update({
        'status': finalStatus,
      });
      String snackbarMessage = newStatus == 'Block'
          ? '${category.name} Blocked successfully!'
          : '${category.name} Unblocked successfully!';
      if (context.mounted) {
        showOverlaySnackbar(
          context,
          snackbarMessage,
          newStatus == 'UnBlock'
              ? WebColors.activeGreeLite
              : WebColors.errorRed,
        );
      }
    } catch (e) {
      showOverlaySnackbar(
        context,
        'Error updating brand status',
        WebColors.errorRed,
      );
    }
  }

    // ! Delete Brands
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.collection('brands').doc(brand.id).delete();
      debugPrint('brand deleted successfully: ${brand.name}');
    } catch (e) {
      throw Exception('Failed to delete brand: $e');
    }
  }

}