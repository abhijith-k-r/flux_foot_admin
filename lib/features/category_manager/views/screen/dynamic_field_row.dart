// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/category_manager/model/dynamic_field_model.dart';
import 'package:google_fonts/google_fonts.dart';

//! --- Dynamic Field Row Widget ---
class DynamicFieldRow extends StatefulWidget {
  final DynamicFieldModel field;
  final VoidCallback onRemove;
  final Function(String) onLabelChanged;
  final Function(FieldType) onTypeChanged;
  final Function(bool) onRequiredChanged;
  final Function(List<String>) onOptionsChanged;

  const DynamicFieldRow({
    super.key,
    required this.field,
    required this.onRemove,
    required this.onLabelChanged,
    required this.onTypeChanged,
    required this.onRequiredChanged,
    required this.onOptionsChanged,
  });

  @override
  State<DynamicFieldRow> createState() => _DynamicFieldRowState();
}

class _DynamicFieldRowState extends State<DynamicFieldRow> {
  late TextEditingController labelController;
  late TextEditingController optionsController;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.field.label);
    optionsController = TextEditingController(
      text: widget.field.options?.join(', ') ?? '',
    );
  }

  @override
  void dispose() {
    labelController.dispose();
    optionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: WebColors.bgDarkGrey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: WebColors.textWhiteLite.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Field Label Input
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field Label',
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: WebColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: labelController,
                      style: TextStyle(
                        color: WebColors.textWhite,
                        fontSize: 14,
                      ),
                      onChanged: widget.onLabelChanged,
                      decoration: InputDecoration(
                        hintText: 'e.g., Material, Size, Color',
                        hintStyle: GoogleFonts.openSans(
                          color: WebColors.textWhiteLite,
                          fontSize: 14,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Field Type Dropdown
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Field Type',
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: WebColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<FieldType>(
                      value: widget.field.type,
                      dropdownColor: WebColors.bgDarkGrey,
                      style: TextStyle(
                        color: WebColors.textWhite,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      items: FieldType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(_getFieldTypeName(type)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          widget.onTypeChanged(value);
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Delete Button
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red.shade400,
                  iconSize: 20,
                  tooltip: 'Remove field',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Options Input (for Selection List type)
          if (widget.field.type == FieldType.sellerSelectionList) ...[
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Options (comma-separated)',
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: WebColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: optionsController,
                  style: TextStyle(color: WebColors.textWhite, fontSize: 14),
                  onChanged: (value) {
                    final options = value
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                    widget.onOptionsChanged(options);
                  },
                  decoration: InputDecoration(
                    hintText: 'e.g., Small, Medium, Large, X-Large',
                    hintStyle: GoogleFonts.openSans(
                      color: WebColors.textWhiteLite,
                      fontSize: 14,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Required Checkbox
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: widget.field.isRequired,
                onChanged: (value) => widget.onRequiredChanged(value ?? false),
                activeColor: WebColors.buttonBlue,
              ),
              Text(
                'Required field',
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  color: WebColors.textWhiteLite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFieldTypeName(FieldType type) {
    switch (type) {
      case FieldType.textInput:
        return 'Text Input';
      case FieldType.sellerSelectionList:
        return 'Seller Selection List';
      case FieldType.booleanToggle:
        return 'Boolean/Toggle';
      case FieldType.number:
        return 'Number';
    }
  }
}
