import 'dart:async';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_carousel_service.dart';
import 'package:flux_foot_admin/features/carousel_image/model/carousel_model.dart';
import 'package:uuid/uuid.dart';

class CarouselProvider extends ChangeNotifier {
  final FirebaseCarouselService _firebaseService = FirebaseCarouselService();
  final cloudinary = CloudinaryPublic('dryij9oei', 'sr_default', cache: false);
  final _uuid = const Uuid();

  // Local State
  List<CarouselModel> _slides = [];
  bool _autoRotate = true;
  int _rotationInterval = 5;
  String _scrollDirection = 'horizontal';
  
  bool _isUploading = false;
  bool _isLoading = false;

  StreamSubscription<CarouselData?>? _dataSubscription;

  List<CarouselModel> get slides => _slides;
  bool get autoRotate => _autoRotate;
  int get rotationInterval => _rotationInterval;
  String get scrollDirection => _scrollDirection;
  bool get isUploading => _isUploading;
  bool get isLoading => _isLoading;

  CarouselProvider() {
    _initStreams();
  }

  void _initStreams() {
    _isLoading = true;
    notifyListeners();
    
    _dataSubscription = _firebaseService.getCarouselData().listen((data) {
      if (data != null) {
        _slides = data.slides;
        _autoRotate = data.settings.autoRotate;
        _rotationInterval = data.settings.rotationInterval;
        _scrollDirection = data.settings.scrollDirection;
      }
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
       debugPrint("Error listening to carousel data: $e");
       _isLoading = false;
       notifyListeners();
    });
  }

  void _setUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  // ! Local Updates (Not Saved Yet)

  void addSlideLocally(CarouselModel slide) {
    _slides.add(slide);
    notifyListeners();
  }

  void removeSlideLocally(String id) {
    _slides.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void updateSlideTextLocally(String id, String newText) {
    final index = _slides.indexWhere((s) => s.id == id);
    if (index != -1) {
      _slides[index] = _slides[index].copyWith(text: newText);
    }
  }

  // ! Settings Updates (Local)
  void toggleAutoRotate(bool value) {
    _autoRotate = value;
    notifyListeners();
  }

  void setRotationInterval(int value) {
    _rotationInterval = value;
    notifyListeners();
  }

  void setScrollDirection(String direction) {
    _scrollDirection = direction;
    notifyListeners();
  }

  // ! Manual Adjustment (Local)
  void rotateLeft() {
    if (_slides.isEmpty) return;
    final last = _slides.removeLast();
    _slides.insert(0, last);
    notifyListeners();
  }

  void rotateRight() {
    if (_slides.isEmpty) return;
    final first = _slides.removeAt(0);
    _slides.add(first);
    notifyListeners();
  }

  void shuffleSlides() {
    _slides.shuffle();
    notifyListeners();
  }

  // ! Upload
  Future<void> uploadImage(PlatformFile file) async {
    _setUploading(true);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path!,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      final newSlide = CarouselModel(
        id: _uuid.v4(),
        imageUrl: response.secureUrl,
        text: '',
        createdAt: DateTime.now(),
      );

      addSlideLocally(newSlide);
      
    } catch (e) {
      debugPrint('Error uploading image: $e');
    } finally {
      _setUploading(false);
    }
  }

  // ! Save EVERYTHING to Firebase
  Future<void> saveAllChanges() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final settings = CarouselSettingsModel(
        autoRotate: _autoRotate,
        rotationInterval: _rotationInterval,
        scrollDirection: _scrollDirection,
      );
      
      final data = CarouselData(
        slides: _slides,
        settings: settings,
      );

      await _firebaseService.saveCarouselData(data);
      
    } catch (e) {
      debugPrint('Error saving changes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    super.dispose();
  }
}
