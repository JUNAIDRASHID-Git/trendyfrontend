import 'dart:async';
import 'package:flutter/material.dart';

class AutoSlidingBanner extends StatefulWidget {
  const AutoSlidingBanner({super.key});

  @override
  State<AutoSlidingBanner> createState() => _AutoSlidingBannerState();
}

class _AutoSlidingBannerState extends State<AutoSlidingBanner> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  final _banners = ["assets/images/banner_2.jpg", "assets/images/banner_1.jpg"];

  @override
  void initState() {
    super.initState();

    // Start auto sliding every 4 seconds
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => _nextPage());
  }

  void _nextPage() {
    if (!mounted) return;
    final nextPage = (_page + 1) % _banners.length;
    _controller.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 5,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (index) {
                setState(() {
                  _page = index;
                });
              },
              itemBuilder:
                  (_, i) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_banners[i]),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: _page == i ? 24 : 6,
                  decoration: BoxDecoration(
                    color: _page == i ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
