import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_category_service.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/model/dynamic_field_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final FirebaseCategoryService _firebaseCategoryService =
      FirebaseCategoryService();

  bool _isLoading = false;
  List<CategoryModel> _categories = [];
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<DynamicFieldModel> dynamicFields = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  final String _isActive = '';
  bool _isEditDataLoaded = false;

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

  // ! Dynamic Field Management
  void addDynamicField() {
    dynamicFields.add(
      DynamicFieldModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: '',
        type: FieldType.textInput,
      ),
    );
    notifyListeners();
  }

  void removeDynamicField(String id) {
    dynamicFields.removeWhere((field) => field.id == id);
    notifyListeners();
  }

  void updateFieldLabel(String id, String label) {
    try {
      final field = dynamicFields.firstWhere((f) => f.id == id);
      field.label = label;
      notifyListeners();
    } catch (e) {
      debugPrint('Field not found: $id');
    }
  }

  void updateFieldType(String id, FieldType type) {
    try {
      final field = dynamicFields.firstWhere((f) => f.id == id);
      field.type = type;
      // Clear options if switching away from selectionList
      if (type != FieldType.sellerSelectionList) {
        field.options = null;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Field not found: $id');
    }
  }

  void updateFieldRequired(String id, bool isRequired) {
    try {
      final field = dynamicFields.firstWhere((f) => f.id == id);
      field.isRequired = isRequired;
      notifyListeners();
    } catch (e) {
      debugPrint('Field not found: $id');
    }
  }

  void updateFieldOptions(String id, List<String> options) {
    try {
      final field = dynamicFields.firstWhere((f) => f.id == id);
      field.options = options;
      notifyListeners();
    } catch (e) {
      debugPrint('Field not found: $id');
    }
  }

  //! Validation
  String? validateFields() {
    if (_nameController.text.trim().isEmpty) {
      return 'Category name is required';
    }

    for (var field in dynamicFields) {
      if (field.label.trim().isEmpty) {
        return 'All field labels must be filled';
      }

      if (field.type == FieldType.sellerSelectionList) {
        if (field.options == null || field.options!.isEmpty) {
          return 'Selection list "${field.label}" must have at least one option';
        }
      }
    }

    return null;
  }

  // ! Add Category
  Future<bool> addCategories({
    required String name,
    String? description,
  }) async {
    if (name.isEmpty) return false;

    // Validate before saving
    final validationError = validateFields();
    if (validationError != null) {
      debugPrint('Validation Error: $validationError');
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final newCategory = CategoryModel(
        id: '', // Firestore will generate this
        name: name.trim(),
        description: description?.trim(),
        status: 'active',
        dynamicFields: List.from(dynamicFields),
        createdAt: DateTime.now(),
      );

      await _firebaseCategoryService.addCategory(newCategory);

      // Clear form after successful save
      clearForm();

      return true;
    } catch (e) {
      debugPrint('Error from viewModel: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ! Edit Categoory
  Future<bool> updateExistingCategory({
    required String id,
    required String name,
    String? description,
  }) async {
    if (name.isEmpty || id.isEmpty) return false;

    // Validate before saving
    final validationError = validateFields();
    if (validationError != null) {
      debugPrint('Validation Error: $validationError');
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final updatedCategory = CategoryModel(
        id: id,
        name: name.trim(),
        description: description?.trim(),
        status: 'active',
        dynamicFields: List.from(dynamicFields),
        createdAt: DateTime.now(),
      );

      await _firebaseCategoryService.updateCategory(updatedCategory);

      clearForm();

      return true;
    } catch (e) {
      debugPrint('Error updating category from ViewModel: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
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

  // !Load category for editing
  void loadCategoryForEdit(CategoryModel category) {
    if (_isEditDataLoaded) return;

    _nameController.text = category.name;
    _descriptionController.text = category.description ?? '';
    dynamicFields = category.dynamicFields
        .map(
          (field) => DynamicFieldModel(
            id: field.id,
            label: field.label,
            type: field.type,
            isRequired: field.isRequired,
            options: field.options != null ? List.from(field.options!) : null,
          ),
        )
        .toList();

    _isEditDataLoaded = true;
    notifyListeners();
  }

  //! Clear form
  void clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    dynamicFields.clear();
    _isEditDataLoaded = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
