import 'package:flutter/material.dart';

class AlienDisplay extends StatelessWidget {
  final List<String> selectedImages; // تستقبل الصور الجاهزة

  const AlienDisplay({
    super.key,
    required this.selectedImages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildAlienGrid(selectedImages),
    );
  }

  Widget _buildAlienGrid(List<String> images) {
    // تحديد عدد الأعمدة بناءً على عدد الصور
    int crossAxisCount;
    if (images.length <= 2) {
      crossAxisCount = 2;
    } else if (images.length <= 4) {
      crossAxisCount = 2;
    } else if (images.length <= 6) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              images[index],
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
