import 'package:doctor/Core/helper/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _activeColor = Color(0xFF2ECC8E);
  static const _inactiveColor = Color(0xFF5A6478);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(top: BorderSide(color: const Color(0xFF2ECC8E), width: 1.5.w)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(ImageAssets.homenavIcon, 'Home', 0),
          _buildItem(ImageAssets.favoritesIocn, 'Favorites', 1),
          _buildItem(ImageAssets.recordsIcon, 'Records', 2),
          _buildItem(ImageAssets.messageIcon, 'Messages', 3),
        ],
      ),
    );
  }

  Widget _buildItem(String assetPath, String label, int index) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? _activeColor : _inactiveColor;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 26.w,
            height: 26.h,
            color: color,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

