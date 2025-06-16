import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/dash_board.dart';
import 'package:trendychef/Presentation/profile/pages/recent_order/recent_order.dart';
import 'package:trendychef/Presentation/profile/widgets/page_view/widgets/page_content_builder.dart';
import 'package:trendychef/Presentation/profile/widgets/page_view/widgets/page_indicator.dart';
import 'package:trendychef/Presentation/profile/widgets/page_view/widgets/tab_button.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabPressed(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          tabButton(_currentIndex, _onTabPressed),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: [
                SingleChildScrollView(child: Dashboard()),
                SingleChildScrollView(child: recentOrder()),
                buildPageContent(
                  "Wishlist",
                  Icons.favorite_border,
                  const Color(0xFFf72585),
                  "Coming Soon! Your wishlist will be available soon.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          buildPageIndicators(_currentIndex),
        ],
      ),
    );
  }
}
