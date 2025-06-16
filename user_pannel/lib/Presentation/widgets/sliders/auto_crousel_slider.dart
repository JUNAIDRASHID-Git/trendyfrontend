import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlidingBanner extends StatefulWidget {
  const AutoSlidingBanner({super.key});

  @override
  State<AutoSlidingBanner> createState() => _AutoSlidingBannerState();
}

class _AutoSlidingBannerState extends State<AutoSlidingBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _banners = [
    "assets/images/banner_2.jpg",
    "assets/images/banner_1.jpg",
  ];

  @override
  void initState() {
    super.initState();

    // Auto-slide every 5 seconds
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 5,
      child: ClipRRect(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _banners.length,
          itemBuilder: (context, index) {
            return Image.asset(
              _banners[index],
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }
}
