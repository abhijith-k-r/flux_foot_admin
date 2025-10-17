import 'package:flutter/material.dart';

class BrandLogoRow extends StatelessWidget {
  final String name;
  final String imageUrl;

  const BrandLogoRow({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}
