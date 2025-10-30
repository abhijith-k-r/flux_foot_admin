import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flux_foot_admin/features/category_manager/model/dynamic_field_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? status;
  final List<DynamicFieldModel> dynamicFields;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.status,
    required this.dynamicFields,
    required this.createdAt,
  });

  factory CategoryModel.fromFirestore(Map<String, dynamic> data, String id) {
    List<DynamicFieldModel> fields = [];
    // Parse dynamic fields from Firestore
    if (data['dynamicFields'] != null && data['dynamicFields'] is List) {
      fields = (data['dynamicFields'] as List)
          .map(
            (fieldData) =>
                DynamicFieldModel.fromJson(fieldData as Map<String, dynamic>),
          )
          .toList();
    }
    return CategoryModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'],
      status: data['status'] ?? '',
      dynamicFields: fields,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'status': status,
      'createdAt': createdAt,
      'dynamicField': dynamicFields.map((field) => field.toJson()).toList(),
    };
  }
}
