import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_category_service.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final FirebaseCategoryService _firebaseCategoryService =
      FirebaseCategoryService();

  bool _isLoading = false;
  List<CategoryModel> _categories = [];
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  final String _isActive = '';

  bool get isLoading => _isLoading;
  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get searchController => _searchController;
  String get isActive => _isActive;

  // ! filtered list based on the search term
  List<CategoryModel> get categories {
    if (_searchTerm.isEmpty) {
      return _categories;
    }

    return _categories.where((category) {
      return category.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          (category.description ?? '').toLowerCase().contains(
            _searchTerm.toLowerCase(),
          );
    }).toList();
  }

  void onSearchTermChanged(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  CategoryViewModel() {
    _firebaseCategoryService.readCategories().listen((categoryList) {
      categoryList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _categories = categoryList;
      _searchController.addListener(() {
        onSearchTermChanged(_searchController.text);
      });
      notifyListeners();
    });
  }

  // ! Add Category
  Future<void> addCategories({
    required String name,
    String? description,
  }) async {
    if (name.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newCategory = CategoryModel(
        id: '',
        name: name,
        description: description,
        status: 'active',
        createdAt: DateTime.now(),
      );

      await _firebaseCategoryService.addCategory(newCategory);
    } catch (e) {
      debugPrint('Error from viewModel: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ! Edit Categoory
  Future<void> updateExistingCategory({
    required String id,
    required String name,
    String? description,
  }) async {
    if (name.isEmpty || id.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final updatedCategory = CategoryModel(
        id: id,
        name: name,
        description: description,
        status: 'active',
        createdAt: DateTime.now(),
      );

      await _firebaseCategoryService.updateCategory(updatedCategory);
    } catch (e) {
      debugPrint('Error updating category from ViewModel: $e');
    } finally {
      _isLoading = false;
    }
  }

  // ! Delete Category
  Future<void> deleteCategories(CategoryModel category) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseCategoryService.deleteCategory(category);
    } catch (e) {
      debugPrint('Error deleting category from ViewModel: $e');
    } finally {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
