// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';

class FirebaseCategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ! Adding a Category
  Future<void> addCategory(CategoryModel categoy) async {
    try {
      await _db.collection('categories').add(categoy.toFirestore());
      debugPrint('Category added successfully to Firestore!');
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  // ! Streaming Categories (Read)
  Stream<List<CategoryModel>> readCategories() {
    return _db.collection('categories').snapshots().map((snampsot) {
      return snampsot.docs
          .map((doc) => CategoryModel.fromFirestore(doc.data(), doc.id))
          .toList();
    });
  }

  // ! Updating a Category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      if (category.id.isEmpty) {
        throw Exception('Category ID is required for updating');
      }

      _db
          .collection('categories')
          .doc(category.id)
          .update(category.toFirestore());
      debugPrint('Category updated successfully: ${category.name}');
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  // ! Update Category Status
  Future<void> updateCategoryStatus(
    BuildContext context,
    CategoryModel category,
    String newStatus,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('categories').doc(category.id).update({
        'status': newStatus.toLowerCase(),
      });

      String finalStatus = newStatus == 'Block' ? 'blocked' : 'active';

      await firestore.collection('categories').doc(category.id).update({
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
        'Error updating Category status',
        WebColors.errorRed,
      );
    }
  }

  // ! Delete Category
  Future<void> deleteCategory(CategoryModel category) async {
    try {
      await _db.collection('categories').doc(category.id).delete();
      debugPrint('Category deleted successfully: ${category.name}');
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}
