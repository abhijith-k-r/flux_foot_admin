class DynamicFieldModel {
  String id;
  String label;
  FieldType type;
  bool isRequired;
  List<String>? options;

  DynamicFieldModel({
    required this.id,
    required this.label,
    required this.type,
    this.isRequired = false,
    this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'type': type.toString().split('.').last,
      'isRequired': isRequired,
      'options': options,
    };
  }

    factory DynamicFieldModel.fromJson(Map<String, dynamic> json) {
    return DynamicFieldModel(
      id: json['id'],
      label: json['label'],
      type: _parseFieldType(json['type']),
      isRequired: json['isRequired'] ?? false,
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
    );
  }

  static FieldType _parseFieldType(dynamic typeValue) {
    if (typeValue == null) return FieldType.textInput;

    final typeString = typeValue.toString();
    try {
      return FieldType.values.firstWhere(
        (e) => e.toString().split('.').last == typeString,
        orElse: () => FieldType.textInput,
      );
    } catch (e) {
      return FieldType.textInput;
    }
  }
}
enum FieldType { textInput, sellerSelectionList, booleanToggle, number }
