import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/banner/get.dart';
import 'package:trendychef/core/services/data/models/banner.dart';

class AutoSlidingBanner extends StatefulWidget {
  const AutoSlidingBanner({super.key});

  @override
  State<AutoSlidingBanner> createState() => _AutoSlidingBannerState();
}

class _AutoSlidingBannerState extends State<AutoSlidingBanner> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  late Future<List<BannerModel>> _bannerFuture;

  @override
  void initState() {
    super.initState();
    _bannerFuture = fetchBanner(); // correct function call
  }

  void _startTimer(int bannerLength) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_page + 1) % bannerLength;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AspectRatio(
            aspectRatio: 16 / 5,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const AspectRatio(
            aspectRatio: 16 / 5,
            child: Center(child: Text("No banners found")),
          );
        }

        final banners = snapshot.data!;
        _startTimer(banners.length);

        return AspectRatio(
          aspectRatio: 16 / 5,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  controller: _controller,
                  itemCount: banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      _page = index;
                    });
                  },
                  itemBuilder: (_, i) => Image.network(
                    banners[i].imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.error, color: Colors.red)),
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
                    banners.length,
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
      },
    );
  }
}
