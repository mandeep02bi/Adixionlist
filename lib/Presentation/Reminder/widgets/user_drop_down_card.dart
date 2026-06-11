import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDropdownCard extends StatefulWidget {
  final String name;
  final String imagePath;
  final Widget expandedSection;

  const UserDropdownCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.expandedSection,
  });

  @override
  State<UserDropdownCard> createState() => _UserDropdownCardState();
}

class _UserDropdownCardState extends State<UserDropdownCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _toggle,
              borderRadius: BorderRadius.circular(16.r),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      widget.imagePath,
                      width: 40.w,
                      height: 38.h,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF888888),
                        size: 24.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? widget.expandedSection
                  : SizedBox(width: double.infinity, height: 0),
            ),
          ],
        ),
      ),
    );
  }
}