import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<String> imgList = [
  ImageAssets.carouselSlider1,
  ImageAssets.carouselSlider2,
  ImageAssets.carouselSlider3,
];

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  late List<Widget> imageSliders;

  @override
  void initState() {
    super.initState();
    imageSliders = imgList
        .map(
          (item) => ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(item, height: 172.h, width: 340.w, fit: BoxFit.cover),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Column(
          children: [
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: orientation == Orientation.portrait ? 2.11 : 4.0,
                onPageChanged: (index, reason) {
                  setState(() => _current = index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.w,
                height: 12.h,
                margin: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 4.w,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );

      },
    );
  }
}


