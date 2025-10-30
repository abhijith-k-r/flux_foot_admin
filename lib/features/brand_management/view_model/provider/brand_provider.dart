import 'dart:async';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_brand_service.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';
import 'package:image_picker/image_picker.dart';

class BrandProvider extends ChangeNotifier {
  final FirebaseBrandService _firebaseBrandService = FirebaseBrandService();

  bool _isLoading = false;
  List<BrandModel> _brands = [];
  final _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  String? _logoUrl;
  final String _isActive = '';
  final ImagePicker _picker = ImagePicker();
  final cloudinary = CloudinaryPublic('dryij9oei', 'sr_default', cache: false);

  StreamSubscription<List<BrandModel>>? _brandsSubscription;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  TextEditingController get nameController => _nameController;
  TextEditingController get searchController => _searchController;
  String? get selectedLogoUrl => _logoUrl;
  String get isActive => _isActive;

  // ! filtered list based on the search term
  List<BrandModel> get brands {
    if (_searchTerm.isEmpty) {
      return _brands;
    }

    return _brands.where((brand) {
      return brand.name.toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();
  }

  void onSearchTermChanged(String term) {
    _searchTerm = term;
    notifyListeners();
    _safeNotify();
  }

  BrandProvider() {
    _searchController.addListener(() {
      onSearchTermChanged(_searchController.text);
    });

    _firebaseBrandService.readBrands().listen((brandList) {
      brandList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _brands = brandList;
      notifyListeners();
    });

    _brandsSubscription = _firebaseBrandService.readBrands().listen((
      brandList,
    ) {
      brandList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _brands = brandList;
      _safeNotify();
    });
  }

  // ! SET INITIAL LOGO URL
  void setInitialLogoUrl(String? url) {
    if (_logoUrl != url) {
      _logoUrl = url;
      notifyListeners();
      _safeNotify();
    }
  }

  // ! To Pick and Upload image
  Future<void> pickAndUploadLogo() async {
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      _logoUrl = response.secureUrl;
      debugPrint('Cloudinary URL: $_logoUrl');
    } catch (e) {
      debugPrint('Error uploading to Cloudinary: $e');
      _logoUrl = null;
    } finally {
      _isLoading = false;
      notifyListeners();
      _safeNotify();
    }
  }

  // ! Clear Selected Logo Url
  void clearSelectedLogoUrl() {
    _logoUrl = null;
    notifyListeners();
    _safeNotify();
  }

  // ! Add Brand
  Future<void> addBrand({required String name, String? logoUrl}) async {
    if (name.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newBrand = BrandModel(
        id: '',
        name: name,
        logoUrl: logoUrl,
        status: 'active',
        createdAt: DateTime.now(),
      );

      await _firebaseBrandService.addBrand(newBrand);
    } catch (e) {
      debugPrint('Error from viewModel: $e');
    } finally {
      _isLoading = false;
      clearSelectedLogoUrl();
      notifyListeners();
      _safeNotify();
    }
  }

  // ! Edit Brand
  Future<void> updateExistingBrand({
    required String id,
    required String name,
    String? logUrl,
  }) async {
    if (name.isEmpty || id.isEmpty) return;

    _isLoading = true;
    notifyListeners();
    _safeNotify();

    try {
      final updateBrand = BrandModel(
        id: id,
        name: name,
        logoUrl: logUrl,
        status: 'active',
        createdAt: DateTime.now(),
      );

      await _firebaseBrandService.updateBrand(updateBrand);
    } catch (e) {
      debugPrint('Error updating Brand from ViewModel: $e');
    } finally {
      _isLoading = false;
      clearSelectedLogoUrl();
      notifyListeners();
      _safeNotify();
    }
  }

  // ! Delete Brand
  Future<void> deleteBrand(BrandModel brand) async {
    _isLoading = true;
    notifyListeners();
    _safeNotify();

    try {
      await _firebaseBrandService.deleteBrand(brand);
    } catch (e) {
      debugPrint('Error deleting category from ViewModel: $e');
    } finally {
      _isLoading = false;
    }
    _safeNotify();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
    _isDisposed = true;
    _brandsSubscription?.cancel();
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _safeNotify() {
    if (!_isDisposed) {
      try {
        notifyListeners();
      } catch (_) {}
    }
  }
}
