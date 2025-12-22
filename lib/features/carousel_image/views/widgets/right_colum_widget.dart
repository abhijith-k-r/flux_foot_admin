import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/controll_button.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/direction_option_widget.dart';
import 'package:provider/provider.dart';

// ! Right Colum
Widget buildRightColumn(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Material(
    color: isDark ? const Color(0xFF1e293b) : Colors.white,
    borderRadius: BorderRadius.circular(12),
    elevation: 1,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Carousel Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Manual Controls
          Text(
            'Arrangement (Local)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Consumer<CarouselProvider>(
            builder: (context, provider, _) => Row(
              children: [
                Expanded(
                  child: buildControlButton(
                    context,
                    Icons.rotate_left,
                    () => provider.rotateLeft(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildControlButton(
                    context,
                    Icons.shuffle,
                    () => provider.shuffleSlides(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildControlButton(
                    context,
                    Icons.rotate_right,
                    () => provider.rotateRight(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
          ),
          const SizedBox(height: 24),
          // Auto Rotate
          Consumer<CarouselProvider>(
            builder: (context, provider, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable Auto-Rotate',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Automatically cycle slides',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4c669a),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: provider.autoRotate,
                  onChanged: provider.toggleAutoRotate,
                  // ignore: deprecated_member_use
                  activeColor: const Color(0xFF135bec),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Rotation Interval
          Text(
            'Rotation Interval (Seconds)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Consumer<CarouselProvider>(
            builder: (context, provider, _) => TextField(
              controller:
                  TextEditingController(
                      text: provider.rotationInterval.toString(),
                    )
                    ..selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: provider.rotationInterval.toString().length,
                      ),
                    ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final intValue = int.tryParse(value);
                if (intValue != null && intValue >= 1 && intValue <= 60) {
                  provider.setRotationInterval(intValue);
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.timer, size: 20),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF135bec)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Scroll Direction
          Text(
            'Scroll Direction',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Consumer<CarouselProvider>(
            builder: (context, provider, _) => Row(
              children: [
                Expanded(
                  child: buildDirectionOption(
                    context,
                    'Horizontal',
                    Icons.swap_horiz,
                    provider.scrollDirection == 'horizontal',
                    () => provider.setScrollDirection('horizontal'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: buildDirectionOption(
                    context,
                    'Vertical',
                    Icons.swap_vert,
                    provider.scrollDirection == 'vertical',
                    () => provider.setScrollDirection('vertical'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
          ),
          const SizedBox(height: 16),
          // Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: Color(0xFF4c669a),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Changes are local until you click "Save All Changes".',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
