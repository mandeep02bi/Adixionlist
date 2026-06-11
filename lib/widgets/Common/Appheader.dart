import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onAdd;
  final String? backgroundImage;

  const AppHeader({
    super.key,
    required this.title,
    this.onBack,
    this.onAdd,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/Header/header.png",
            height: 120,
            width: double.infinity,
            fit: BoxFit.fill,
          ),

          /// 🔵 TOP RIGHT CIRCLE EFFECT (like screenshot)
          // Positioned(
          //   top: -30,
          //   right: -30,
          //   child: Container(
          //     height: 120,
          //     width: 120,
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.15),
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // ),

          /// 🔷 CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 🔙 BACK
                  GestureDetector(
                    onTap: onBack,
                    child: Image.asset(
                      "assets/images/Icons/Patient/Frame.png",
                      height: 52,
                      width: 52,
                      fit: BoxFit.contain,
                    ),
                  ),

                  /// 🏷 TITLE
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  onAdd != null
                      ? GestureDetector(
                          onTap: onAdd,
                          child: Image.asset(
                            "assets/images/Icons/Patient/Add.png",
                            height: 52,
                            width: 52,
                            fit: BoxFit.contain,
                          ),
                        )
                      : const SizedBox(width: 52), // 👈 keeps layout balanced
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
