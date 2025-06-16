import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trendychef/Presentation/cart/cart.dart';
import 'package:trendychef/Presentation/home/home.dart';
import 'package:trendychef/Presentation/home/widget/formfields/search_field.dart';
import 'package:trendychef/Presentation/profile/profile.dart';
import 'package:trendychef/Presentation/search/search.dart';
import 'package:trendychef/Presentation/widgets/containers/logo.dart';
import 'package:trendychef/core/constants/colors.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (_selectedIndex == 0) {
        setState(() {}); // Rebuild when on Shop tab and search input changes
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> get _pages => [
    (searchController.text.trim().isEmpty)
        ? HomePage()
        : SearchPage(searchController: searchController),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                _onNavBarTap(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                _onNavBarTap(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                _onNavBarTap(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leadingWidth: 180,
        leading: IconButton(
          icon: logoContainer(),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_selectedIndex == 0)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 180,
                  height: 45,
                  child: searchField(searchController),
                ),
              ),
            if (screenWidth > 600)
              TextButton(
                onPressed: () => _onNavBarTap(0),
                child: Text(
                  "Shop",
                  style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
            if (screenWidth > 600)
              TextButton(
                onPressed: () => _onNavBarTap(1),
                child: Text(
                  "Cart",
                  style: TextStyle(
                    color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            if (screenWidth > 600)
              TextButton(
                onPressed: () => _onNavBarTap(2),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: _selectedIndex == 2 ? Colors.white : Colors.white70,
                  ),
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[200]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
        ],
      ),
      bottomNavigationBar:
          screenWidth < 600
              ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: GNav(
                          selectedIndex: _selectedIndex,
                          onTabChange: _onNavBarTap,
                          color: AppColors.fontWhite,
                          activeColor: AppColors.fontBlack,
                          tabBackgroundColor: AppColors.secondary,
                          tabBorderRadius: 30,
                          padding: const EdgeInsets.all(16),
                          gap: 5,
                          tabs: const [
                            GButton(icon: Icons.shopify_sharp, text: "Shop"),
                            GButton(
                              icon: IconData(
                                0xec92,
                                fontFamily: 'MaterialIcons',
                              ),
                              text: "Cart",
                            ),
                            GButton(icon: Icons.person, text: "Profile"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              : null,
    );
  }
}
