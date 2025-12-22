
class CarouselModel {
  final String id;
  final String imageUrl;
  final String text;
  final bool isActive;
  final DateTime createdAt;

  CarouselModel({
    required this.id,
    required this.imageUrl,
    required this.text,
    this.isActive = true,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'text': text,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CarouselModel.fromJson(Map<String, dynamic> data) {
    return CarouselModel(
      id: data['id'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      text: data['text'] ?? '',
      isActive: data['isActive'] ?? true,
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
          : DateTime.now(),
    );
  }

  CarouselModel copyWith({
    String? id,
    String? imageUrl,
    String? text,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CarouselModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      text: text ?? this.text,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CarouselSettingsModel {
  final bool autoRotate;
  final int rotationInterval;
  final String scrollDirection;

  CarouselSettingsModel({
    this.autoRotate = true,
    this.rotationInterval = 5,
    this.scrollDirection = 'horizontal',
  });

  Map<String, dynamic> toJson() {
    return {
      'autoRotate': autoRotate,
      'rotationInterval': rotationInterval,
      'scrollDirection': scrollDirection,
    };
  }

  factory CarouselSettingsModel.fromJson(Map<String, dynamic> data) {
    return CarouselSettingsModel(
      autoRotate: data['autoRotate'] ?? true,
      rotationInterval: data['rotationInterval'] ?? 5,
      scrollDirection: data['scrollDirection'] ?? 'horizontal',
    );
  }
}

class CarouselData {
  final List<CarouselModel> slides;
  final CarouselSettingsModel settings;

  CarouselData({
    required this.slides,
    required this.settings,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'slides': slides.map((s) => s.toJson()).toList(),
      'settings': settings.toJson(),
    };
  }

  factory CarouselData.fromFirestore(Map<String, dynamic> data) {
    return CarouselData(
      slides: (data['slides'] as List<dynamic>?)
              ?.map((e) => CarouselModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      settings: data['settings'] != null
          ? CarouselSettingsModel.fromJson(data['settings'])
          : CarouselSettingsModel(),
    );
  }
}
